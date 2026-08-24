import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show DeviceOrientation;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/services/scan_capability.dart';
import '../../domain/services/scan_candidate_detector.dart';
part 'live_scan_camera_view_widgets.dart';


const Color _kAccent = Color.fromARGB(255, 78, 3, 208);

/// Live "hover to detect" scan camera.
///
/// Instead of a shutter tap, this view runs on-device OCR
/// ([google_mlkit_text_recognition]) on a periodic still (~[pollInterval]).
/// When a payable candidate (account / phone / @user / email — see
/// [ScanCandidateDetector]) is seen steadily across [stabilityThreshold]
/// consecutive frames, it captures that same still ONCE and hands it to
/// [onCapture]. The caller runs the authoritative backend OCR and advances the
/// flow to the existing prefilled-editable confirm sheet (PIN still required —
/// this view never moves money).
///
/// Backend-agnostic on purpose: it only returns an image path, so both the AI
/// Scan-to-Pay quick service (which feeds `AiScanCubit.analyzeImage`) and the
/// Send-Funds scan (which feeds `BankScanDataSource.scanBankDetails`) reuse it.
class LiveScanCameraView extends StatefulWidget {
  const LiveScanCameraView({
    super.key,
    required this.onCapture,
    this.onImagePicked,
    this.onManualCapture,
    this.onDeviceResolve,
    this.onResolved,
    this.title = 'Scan to Pay',
    this.hintText =
        'Point at the account details inside the box — we read them automatically',
    this.pollInterval = const Duration(milliseconds: 400),
    this.stabilityThreshold = 2,
    // OCR reads a large central region matching the viewfinder box (was a thin
    // 0.22 band that was hard to line a single line up in — the "not scanning"
    // feel). ~0.6 covers the box so pointing at the details just reads them.
    this.roiHeightFraction = 0.6,
    this.showBack = true,
  });

  /// Fired once with a captured still path — on stable auto-detect OR a manual
  /// capture tap. After this fires the view stops scanning.
  final void Function(String stillPath) onCapture;

  /// Optional gallery/upload handler. When null, [onCapture] is used for picked
  /// images too.
  final void Function(String pickedPath)? onImagePicked;

  /// Optional handler for MANUAL captures (shutter tap / gallery) — the
  /// "tap to take a picture" fallback used on devices without on-device
  /// auto-detect. Callers wire this to the fast per-service OCR route
  /// (/scan/extract) so the fallback bypasses the busy general gateway.
  /// When null, manual captures fall back to [onImagePicked]/[onCapture].
  final void Function(String manualPath)? onManualCapture;

  /// Optional on-device fast-path. Given the ML Kit OCR text of the captured
  /// still, the caller may return an already-built result object (e.g. a
  /// `SmartScanResult`) to route DIRECTLY — skipping the backend GPT-vision
  /// call. Return null to fall back to the normal still + backend OCR
  /// ([onCapture]). Kept as `Object?` so this view stays backend-agnostic: both
  /// scan surfaces pass their own extractor + their own [onResolved] handler.
  final Object? Function(String recognizedText)? onDeviceResolve;

  /// Fired with the object [onDeviceResolve] returned, when the on-device
  /// fast-path short-circuits (no backend upload). Scanning stops afterwards.
  final void Function(Object resolved)? onResolved;

  final String title;
  final String hintText;
  final Duration pollInterval;
  final int stabilityThreshold;

  /// Fraction of the preview height ML Kit OCRs (a centred region, NOT the whole
  /// frame). Sized to cover the purple viewfinder box so the user can point at
  /// the bank details (account number + bank + name) anywhere inside the box and
  /// they're read — natural scanning, not lining a single line up in a thin band.
  final double roiHeightFraction;

  final bool showBack;

  @override
  State<LiveScanCameraView> createState() => _LiveScanCameraViewState();
}

class _LiveScanCameraViewState extends State<LiveScanCameraView>
    with WidgetsBindingObserver {
  CameraController? _controller;
  List<CameraDescription> _cameras = [];
  bool _isInitialized = false;
  bool _cameraError = false;
  String _cameraErrorMsg = '';
  int _selectedCameraIndex = 0;
  bool _isFlashOn = false;
  bool _isDisposing = false;

  final ImagePicker _picker = ImagePicker();
  final ScanCandidateDetector _detector = const ScanCandidateDetector();

  TextRecognizer? _recognizer;
  bool _streaming = false; // camera image stream is running (silent frames)
  DateTime? _lastProcessedAt; // throttle ML Kit to ~pollInterval

  // Maps the device orientation to a rotation compensation (Android) for the
  // ML Kit InputImage. See _inputImageFromCameraImage.
  static const _orientations = <DeviceOrientation, int>{
    DeviceOrientation.portraitUp: 0,
    DeviceOrientation.landscapeLeft: 90,
    DeviceOrientation.portraitDown: 180,
    DeviceOrientation.landscapeRight: 270,
  };

  // Frame-to-frame stability tracking + one-shot fire guard.
  String? _lastCandidate;
  int _stableCount = 0;
  bool _busy = false; // an OCR frame is being processed
  bool _fired = false; // handed a still to the caller; stop everything
  bool _paused = false; // gallery picker / manual capture in progress
  bool _manualCapturing = false;

  // Capability gate: true = on-device ML Kit live auto-detect; false = manual
  // tap-to-capture (older/incapable devices, or ML Kit init/runtime failure).
  bool _autoMode = true;
  int _mlErrors = 0; // consecutive ML Kit failures → degrade to tap mode
  int _badFrames = 0; // consecutive frames we couldn't convert for ML Kit
  static const String _tapHint =
      'Tap the shutter to capture the details — we\'ll read them for you';

  /// Atomically claim the single capture. Returns true for the winner (auto
  /// detect / manual / gallery), false if someone already handed a still off —
  /// so two paths can race without a double navigation. The winner is
  /// responsible for stopping the image stream (awaited) before any takePicture.
  bool _claimCapture() {
    if (_fired) return false;
    _fired = true;
    return true;
  }

  late String _statusHint = widget.hintText;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Capability gate — only spin up on-device ML Kit where it's supported.
    // Otherwise this is a manual tap-to-capture camera; the server does the OCR.
    _autoMode = ScanCapability.autoScanSupported();
    if (_autoMode) {
      try {
        _recognizer = TextRecognizer(script: TextRecognitionScript.latin);
      } catch (_) {
        // ML Kit unavailable on this device — degrade to tap-to-capture.
        ScanCapability.markAutoUnsupported();
        _autoMode = false;
        _recognizer = null;
      }
    }
    _statusHint = _autoMode ? widget.hintText : _tapHint;
    _initializeCamera();
  }

  @override
  void dispose() {
    _isDisposing = true;
    WidgetsBinding.instance.removeObserver(this);
    _stopPoll();
    _recognizer?.close();
    _recognizer = null;
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (_isDisposing) return;
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;

    if (state == AppLifecycleState.inactive) {
      // Stop the image stream (AWAITED) before disposing — disposing a camera
      // that's still streaming throws on both platforms.
      await _stopStreamAwait();
      if (_controller != controller) return; // re-entrant lifecycle change
      await controller.dispose();
      _controller = null;
      if (mounted) setState(() => _isInitialized = false);
    } else if (state == AppLifecycleState.resumed) {
      // Let the user scan again after returning to the app.
      _fired = false;
      _resetStability();
      _initializeCamera();
    }
  }

  // Stream format for ML Kit: NV21 on Android, BGRA8888 on iOS (the two formats
  // google_mlkit_text_recognition accepts from a live camera stream). In tap
  // mode there is no stream (takePicture only), so JPEG is fine.
  ImageFormatGroup get _streamFormatGroup {
    if (!_autoMode) return ImageFormatGroup.jpeg;
    return Platform.isAndroid
        ? ImageFormatGroup.nv21
        : ImageFormatGroup.bgra8888;
  }

  // ── Camera lifecycle ───────────────────────────────────────────────────────

  Future<void> _initializeCamera() async {
    if (_isDisposing) return;
    if (mounted) {
      setState(() {
        _cameraError = false;
        _cameraErrorMsg = '';
        _isInitialized = false;
      });
    }

    try {
      await _disposeControllerOnly();

      final status = await Permission.camera.request();
      if (!status.isGranted) {
        _setCameraError(
          'Camera permission is needed to scan. Grant it in Settings, or '
          'upload an image from your device instead.',
        );
        return;
      }

      _cameras = await availableCameras();
      if (_cameras.isEmpty) {
        _setCameraError(
          'No camera is available on this device. Upload an image instead.',
        );
        return;
      }

      // medium is the most broadly-compatible preset (matches the legacy scan
      // screen) and keeps per-tick stills small/fast for on-device OCR.
      _controller = CameraController(
        _cameras[_selectedCameraIndex],
        ResolutionPreset.medium,
        enableAudio: false,
        imageFormatGroup: _streamFormatGroup,
      );

      await _controller!.initialize().timeout(
            const Duration(seconds: 12),
            onTimeout: () => throw TimeoutException('camera init timed out'),
          );

      if (mounted && !_isDisposing) {
        setState(() {
          _isInitialized = true;
          _cameraError = false;
        });
        _startPoll();
      }
    } catch (_) {
      _setCameraError(
        'Couldn\'t start the camera. Tap retry, or upload an image instead.',
      );
    }
  }

  Future<void> _disposeControllerOnly() async {
    await _stopStreamAwait();
    if (_controller != null) {
      await _controller!.dispose();
      _controller = null;
    }
  }

  void _setCameraError(String message) {
    if (mounted && !_isDisposing) {
      setState(() {
        _cameraError = true;
        _cameraErrorMsg = message;
        _isInitialized = false;
      });
    }
  }

  Future<void> _switchCamera() async {
    if (_cameras.length < 2 || _isDisposing) return;
    if (mounted) setState(() => _isInitialized = false);
    // _disposeControllerOnly stops the image stream (awaited) before disposing.
    await _disposeControllerOnly();

    _selectedCameraIndex = (_selectedCameraIndex + 1) % _cameras.length;
    _controller = CameraController(
      _cameras[_selectedCameraIndex],
      ResolutionPreset.medium,
      enableAudio: false,
      imageFormatGroup: _streamFormatGroup,
    );
    try {
      await _controller!.initialize();
      if (mounted && !_isDisposing) {
        setState(() => _isInitialized = true);
        _isFlashOn = false;
        _startPoll();
      }
    } catch (_) {
      _setCameraError('Failed to switch camera. Tap retry.');
    }
  }

  Future<void> _toggleFlash() async {
    final controller = _controller;
    if (controller == null || _isDisposing) return;
    try {
      setState(() => _isFlashOn = !_isFlashOn);
      await controller.setFlashMode(_isFlashOn ? FlashMode.torch : FlashMode.off);
    } catch (_) {
      if (mounted && !_isDisposing) setState(() => _isFlashOn = !_isFlashOn);
    }
  }

  // ── Detection loop ─────────────────────────────────────────────────────────

  // Start SILENT auto-detection: a continuous camera image stream analysed
  // on-device (no shutter, no sound, no intermediate files) — the standard
  // live-OCR pattern. One real photo is taken only at the moment of a stable
  // detection (see _captureFinalStill).
  void _startPoll() {
    if (!_autoMode) return; // tap-to-capture mode: no on-device detection loop
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;
    if (_streaming) return;
    _paused = false;
    _resetStability();
    _badFrames = 0;
    _lastProcessedAt = null;
    try {
      controller.startImageStream(_processFrame);
      _streaming = true;
    } catch (_) {
      // Stream unsupported on this device — fall back to tap-to-capture.
      _degradeToTap();
    }
  }

  // Fire-and-forget stop for lifecycle/dispose/switch paths.
  void _stopPoll() {
    if (!_streaming) return;
    _streaming = false;
    final controller = _controller;
    if (controller != null && controller.value.isStreamingImages) {
      controller.stopImageStream().catchError((_) {});
    }
  }

  // Awaited stop — used before any takePicture so the still-capture pipeline
  // never races the running image stream.
  Future<void> _stopStreamAwait() async {
    if (!_streaming) return;
    _streaming = false;
    final controller = _controller;
    if (controller != null && controller.value.isStreamingImages) {
      try {
        await controller.stopImageStream();
      } catch (_) {}
    }
  }

  void _degradeToTap() {
    _streaming = false;
    ScanCapability.markAutoUnsupported();
    if (mounted) {
      setState(() {
        _autoMode = false;
        _statusHint = _tapHint;
      });
    }
  }

  void _resetStability() {
    _lastCandidate = null;
    _stableCount = 0;
  }

  // Per-frame handler — SILENT (no shutter). Throttled to ~pollInterval and
  // reentrancy-guarded; runs on-device OCR and only takes a real photo when a
  // payable candidate is stable across [stabilityThreshold] frames.
  Future<void> _processFrame(CameraImage image) async {
    if (_busy || _fired || _paused || _isDisposing || !_streaming) return;
    final recognizer = _recognizer;
    if (recognizer == null) return;
    // ML Kit on every camera frame (~30fps) is wasteful — process one per window.
    final now = DateTime.now();
    if (_lastProcessedAt != null &&
        now.difference(_lastProcessedAt!) < widget.pollInterval) {
      return;
    }
    _lastProcessedAt = now;

    final inputImage = _inputImageFromCameraImage(image);
    if (inputImage == null) {
      // This device's live frames aren't in a shape ML Kit can read (rare:
      // old device that ignores the NV21 request and streams multi-plane
      // YUV_420_888). Rather than silently never-detecting, degrade to the
      // tap-to-capture + server-OCR path after a few unusable frames so the
      // scan still works end-to-end.
      if (++_badFrames >= 5) {
        _stopPoll();
        _degradeToTap();
      }
      return;
    }
    _badFrames = 0;

    _busy = true;
    try {
      String recognizedText;
      try {
        final recognized = await recognizer.processImage(inputImage);
        recognizedText = recognized.text;
        _mlErrors = 0;
      } catch (_) {
        // ML Kit failed on a device the version check thought was capable.
        // After a few consecutive failures, degrade to tap-to-capture so the
        // scan still works (server OCR) instead of silently doing nothing.
        if (++_mlErrors >= 3) {
          _stopPoll();
          _degradeToTap();
        }
        return;
      }
      if (_fired || _paused || _isDisposing) return;

      final candidate = _detector.detect(recognizedText);
      if (candidate == null) {
        _resetStability();
        _updateHint(widget.hintText);
        return;
      }

      if (candidate.normalized == _lastCandidate) {
        _stableCount++;
      } else {
        _lastCandidate = candidate.normalized;
        _stableCount = 1;
      }
      _updateHint(_detectingHint(candidate));

      if (_stableCount >= widget.stabilityThreshold && _claimCapture()) {
        await _captureFinalStill();
      }
    } catch (_) {
      // Transient (dispose race / bad frame) — ignore.
    } finally {
      _busy = false;
    }
  }

  // The ONE real photo of the whole scan: taken after a stable detection, then
  // handed to the caller's backend OCR. Stops the stream first so the still
  // capture doesn't race it.
  Future<void> _captureFinalStill() async {
    await _stopStreamAwait();
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) {
      // Controller vanished during the stream stop (e.g. backgrounded) — don't
      // leave the fire-guard stuck; resume auto-detection when possible.
      if (!_isDisposing) {
        _fired = false;
        _startPoll();
      }
      return;
    }
    try {
      if (mounted) setState(() => _statusHint = 'Confirming details…');
      final shot = await controller.takePicture();
      if (await _tryOnDeviceHandoff(shot.path)) return;
      widget.onCapture(shot.path);
    } catch (_) {
      // Capture failed after a valid detection — let the user try again.
      if (!_isDisposing) {
        _fired = false;
        _startPoll();
      }
    }
  }

  // On-device fast-path: OCR the captured still ([path]) with ML Kit (full
  // frame, EXIF-correct via fromFilePath) and, if the caller's [onDeviceResolve]
  // returns a result, route it DIRECTLY — no backend upload / GPT-vision call.
  // Returns true when it short-circuited (caller must NOT also fire the backend
  // handler). Falls through (false) on any hiccup or a low-confidence parse, so
  // the backend path is always the safety net. Only runs when this device has a
  // live ML Kit recognizer (auto-capable) AND the caller wired both callbacks.
  Future<bool> _tryOnDeviceHandoff(String path) async {
    final resolve = widget.onDeviceResolve;
    final onResolved = widget.onResolved;
    final recognizer = _recognizer;
    if (resolve == null || onResolved == null || recognizer == null) {
      return false;
    }
    try {
      final recognized =
          await recognizer.processImage(InputImage.fromFilePath(path));
      if (_isDisposing) return false;
      final result = resolve(recognized.text);
      if (result != null) {
        onResolved(result);
        return true;
      }
      // SECOND PASS for hard surfaces (low-light chalk / faint handwriting on
      // walls): when the raw frame yielded no meaningful digit run, re-run ML
      // Kit on a contrast-stretched grayscale upscale of the same still. Cheap
      // (one extra local inference), and exactly what recovers dim wall signs
      // that the backend GPT round-trip would otherwise be burned on.
      if (!_hasDigitRun(recognized.text)) {
        final boosted = await _contrastBoostedCopy(path);
        if (boosted != null && !_isDisposing) {
          final second =
              await recognizer.processImage(InputImage.fromFilePath(boosted));
          if (_isDisposing) return false;
          final retry = resolve(second.text);
          if (retry != null) {
            onResolved(retry);
            return true;
          }
        }
      }
    } catch (_) {
      // On-device OCR/parse hiccup → fall through to the backend handler.
    }
    return false;
  }

  /// True when [text] contains any run of ≥8 digits once separators collapse —
  /// the cheap "did OCR see the number at all" gate for the second pass.
  static bool _hasDigitRun(String text) {
    final collapsed = text.replaceAll(RegExp(r'[\s\-.,·]'), '');
    return RegExp(r'\d{8,}').hasMatch(collapsed);
  }

  /// Write a grayscale, contrast-stretched, 1.5× upscaled copy of the still to
  /// a temp file for the second OCR pass. Returns null on any failure.
  Future<String?> _contrastBoostedCopy(String path) async {
    try {
      final bytes = await File(path).readAsBytes();
      var im = img.decodeImage(bytes);
      if (im == null) return null;
      im = img.grayscale(im);
      // Stretch levels so faint marker strokes separate from the wall; a mild
      // gamma lift also recovers under-exposed (no-flash) captures.
      im = img.adjustColor(im, contrast: 1.4, gamma: 0.8);
      if (im.width < 1600) {
        im = img.copyResize(im, width: (im.width * 1.5).round());
      }
      final out = File(
          '${File(path).parent.path}/boost_${DateTime.now().millisecondsSinceEpoch}.jpg');
      await out.writeAsBytes(img.encodeJpg(im, quality: 92));
      return out.path;
    } catch (_) {
      return null;
    }
  }

  // Converts a live camera frame to an ML Kit InputImage. We request NV21 on
  // Android / BGRA8888 on iOS (see _streamFormatGroup), so we build the
  // InputImage for THAT format directly.
  //
  // Critically we do NOT derive the format from image.format.raw: on many
  // Android devices the camera plugin converts the frame to a single NV21 plane
  // for us but still reports the pre-conversion raw code (YUV_420_888 = 35).
  // Gating on that raw value made every frame fail the nv21 check and return
  // null — so on-device detection never fired and the scan never captured.
  // Trusting the requested format (and the single-plane invariant the plugin
  // guarantees for NV21/BGRA8888) is what makes auto-detect actually work.
  InputImage? _inputImageFromCameraImage(CameraImage image) {
    final controller = _controller;
    if (controller == null || _cameras.isEmpty) return null;
    final camera = _cameras[_selectedCameraIndex];
    final sensorOrientation = camera.sensorOrientation;

    InputImageRotation? rotation;
    if (Platform.isIOS) {
      rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    } else {
      final rc = _orientations[controller.value.deviceOrientation];
      if (rc == null) return null;
      final compensated = camera.lensDirection == CameraLensDirection.front
          ? (sensorOrientation + rc) % 360
          : (sensorOrientation - rc + 360) % 360;
      rotation = InputImageRotationValue.fromRawValue(compensated);
    }
    if (rotation == null) return null;

    // NV21 (Android) and BGRA8888 (iOS) are both single-plane. If a device
    // ignored the request and streamed multi-plane YUV_420_888, we can't feed
    // it as-is — return null so the caller degrades to tap-to-capture.
    if (image.planes.length != 1) return null;
    final plane = image.planes.first;

    final format =
        Platform.isIOS ? InputImageFormat.bgra8888 : InputImageFormat.nv21;

    // Crop to the centred detection band (the green ROI) so ML Kit reads only a
    // sliver of the frame — the speed + stability win. Which sensor axis to
    // narrow depends on the display rotation: at 90/270 the on-screen horizontal
    // band maps to an x-band in the sensor buffer; at 0/180 it maps to a y-band.
    // If the buffer isn't in a shape we can crop safely we fall back to the full
    // frame (previous behaviour) — never a corrupt crop.
    final bool narrowX = rotation == InputImageRotation.rotation90deg ||
        rotation == InputImageRotation.rotation270deg;
    final roi = _croppedRoi(image, plane, narrowX: narrowX);
    if (roi != null) {
      return InputImage.fromBytes(
        bytes: roi.bytes,
        metadata: InputImageMetadata(
          size: Size(roi.width.toDouble(), roi.height.toDouble()),
          rotation: rotation,
          format: format,
          bytesPerRow: roi.bytesPerRow,
        ),
      );
    }

    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation,
        format: format,
        bytesPerRow: plane.bytesPerRow,
      ),
    );
  }

  /// Crops the single-plane camera buffer to the centred detection band and
  /// returns a tightly-packed ML Kit buffer, or null if the buffer can't be
  /// cropped safely (the caller then OCRs the full frame). Runs a few times a
  /// second on a ~quarter-frame memcpy, so its cost is negligible next to OCR.
  _RoiBuffer? _croppedRoi(CameraImage image, Plane plane,
      {required bool narrowX}) {
    final int w = image.width;
    final int h = image.height;
    final int rowStride = plane.bytesPerRow;
    final Uint8List src = plane.bytes;
    final double f = widget.roiHeightFraction.clamp(0.08, 0.9);

    // ROI rect in sensor-buffer space; centre it, keep the non-narrowed axis
    // full. Even-align every edge (NV21 chroma is 2x2-subsampled).
    int cw = narrowX ? (w * f).round() : w;
    int ch = narrowX ? h : (h * f).round();
    cw -= cw % 2;
    ch -= ch % 2;
    if (cw < 16 || ch < 16) return null;
    int cx = (w - cw) ~/ 2;
    int cy = (h - ch) ~/ 2;
    cx -= cx % 2;
    cy -= cy % 2;

    try {
      if (Platform.isIOS) {
        // BGRA8888: 4 bytes/px. Row-crop via the source stride (handles row
        // padding); the dest is tightly packed.
        if (src.length < rowStride * h) return null;
        final int dstStride = cw * 4;
        final out = Uint8List(dstStride * ch);
        for (int r = 0; r < ch; r++) {
          final int srcOff = (cy + r) * rowStride + cx * 4;
          out.setRange(r * dstStride, r * dstStride + dstStride, src, srcOff);
        }
        return _RoiBuffer(out, cw, ch, dstStride);
      }

      // NV21: Y plane (h rows @ stride) then interleaved VU (h/2 rows @ stride).
      // Handle BOTH tightly-packed (stride == width) and row-padded
      // (stride > width) buffers by addressing the source via `stride` while the
      // dest stays packed. Guard on stride >= width and the exact strided length
      // so an unexpected layout falls back to the full frame instead of feeding
      // ML Kit a corrupt crop.
      final int stride = rowStride;
      if (stride < w) return null;
      final int ySize = stride * h;
      if (src.length < ySize + ySize ~/ 2) return null;
      final out = Uint8List(cw * ch + (cw * ch) ~/ 2);
      // Y
      for (int r = 0; r < ch; r++) {
        final int srcOff = (cy + r) * stride + cx;
        out.setRange(r * cw, r * cw + cw, src, srcOff);
      }
      // VU (V,U interleaved; one chroma row per two luma rows, same columns).
      final int dstVuBase = cw * ch;
      for (int r = 0; r < ch ~/ 2; r++) {
        final int srcOff = ySize + ((cy ~/ 2) + r) * stride + cx;
        out.setRange(dstVuBase + r * cw, dstVuBase + r * cw + cw, src, srcOff);
      }
      return _RoiBuffer(out, cw, ch, cw);
    } catch (_) {
      // Any indexing surprise on an oddly-shaped buffer → full-frame fallback.
      return null;
    }
  }

  String _detectingHint(ScanCandidate c) {
    switch (c.type) {
      case ScanCandidateType.account:
        return 'Account number detected — hold steady…';
      case ScanCandidateType.phone:
        return 'Phone number detected — hold steady…';
      case ScanCandidateType.username:
        return 'Lazervault user detected — hold steady…';
      case ScanCandidateType.email:
        return 'Email detected — hold steady…';
      case ScanCandidateType.amount:
        return 'Payment details detected — hold steady…';
    }
  }

  void _updateHint(String hint) {
    if (!mounted || _statusHint == hint) return;
    setState(() => _statusHint = hint);
  }

  // ── Manual fallbacks ───────────────────────────────────────────────────────

  Future<void> _manualCapture() async {
    if (_fired || _isDisposing || _manualCapturing) return;
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;
    _manualCapturing = true;
    _paused = true; // freeze auto-detection while we take the manual shot
    try {
      // Claim first so an in-flight auto frame bails, then STOP the live stream
      // (awaited) so the still-capture pipeline doesn't race it.
      if (!_claimCapture()) return; // an auto detection already won
      await _stopStreamAwait();
      final shot = await controller.takePicture();
      if (mounted) setState(() => _statusHint = 'Confirming details…');
      // Try the on-device fast-path first (skips the backend when confident).
      if (await _tryOnDeviceHandoff(shot.path)) return;
      // Only the tap-to-capture FALLBACK (incapable device / ML Kit degraded)
      // routes to the lean per-service OCR. A manual tap in AUTO mode keeps the
      // full route so its gateway-side user-resolution behaviour is unchanged.
      final handler = (!_autoMode && widget.onManualCapture != null)
          ? widget.onManualCapture!
          : widget.onCapture;
      handler(shot.path);
    } catch (_) {
      if (!_isDisposing) {
        _fired = false;
        _startPoll(); // resume scanning on failure
      }
      if (mounted && !_isDisposing) {
        Get.snackbar('Capture error', 'Couldn\'t capture the image. Try again.',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP);
      }
    } finally {
      _manualCapturing = false;
    }
  }

  Future<void> _pickFromGallery() async {
    if (_isDisposing || _fired) return;
    // Pause auto-detection so the live camera underneath can't fire and navigate
    // while the OS gallery picker is open. Awaited stop so a quick resume
    // (user cancels) doesn't race the still-stopping stream.
    _paused = true;
    await _stopStreamAwait();
    try {
      // Cap the picked image to 2048px — backend OCR never needs more, and it
      // keeps the upload small/fast (a raw 4000px+ phone photo would otherwise
      // slow OCR and risk the storage-service size limit). Matches the camera's
      // own modest ResolutionPreset.medium stills.
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 2048,
        maxHeight: 2048,
        imageQuality: 85,
      );
      if (image == null || _isDisposing) {
        if (!_fired && mounted) _startPoll(); // user cancelled — resume scanning
        return;
      }
      if (!_claimCapture()) return; // auto tick already handed a still off
      if (mounted) setState(() => _statusHint = 'Confirming details…');
      // Try the on-device fast-path first (a clear gallery photo OCRs well).
      if (await _tryOnDeviceHandoff(image.path)) return;
      // Lean per-service route only in tap-fallback mode (see _manualCapture).
      final handler = (!_autoMode && widget.onManualCapture != null)
          ? widget.onManualCapture!
          : (widget.onImagePicked ?? widget.onCapture);
      handler(image.path);
    } catch (_) {
      if (!_fired && mounted) _startPoll();
      if (mounted && !_isDisposing) {
        Get.snackbar('Gallery error', 'Couldn\'t open the gallery. Try again.',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP);
      }
    }
  }

  // ── UI ─────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    if (_cameraError) return _buildErrorView();
    if (!_isInitialized || _controller == null) return _buildLoadingView();
    return _buildCameraView();
  }

  Widget _buildCameraView() {
    return Stack(
      children: [
        Positioned.fill(
          child: AspectRatio(
            aspectRatio: _controller!.value.aspectRatio,
            child: CameraPreview(_controller!),
          ),
        ),
        Positioned.fill(
          child: CustomPaint(
            painter: const CameraOverlayPainter(),
          ),
        ),

        // Title chip + live detection hint.
        Positioned(
          top: MediaQuery.of(context).padding.top + 20.h,
          left: 0,
          right: 0,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.document_scanner_outlined,
                        color: _kAccent, size: 20.sp),
                    SizedBox(width: 8.w),
                    Text(widget.title,
                        style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 32.w),
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_fired) ...[
                      SizedBox(
                          width: 16.w, height: 16.w, child: LazerVaultLoader.small()),
                      SizedBox(width: 10.w),
                    ],
                    Flexible(
                      child: Text(
                        _statusHint,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(fontSize: 13.sp, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Top controls.
        Positioned(
          top: MediaQuery.of(context).padding.top + 16.h,
          left: 16.w,
          right: 16.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (widget.showBack)
                _circleBtn(Icons.arrow_back, () => Get.back())
              else
                SizedBox(width: 48.w),
              _circleBtn(_isFlashOn ? Icons.flash_on : Icons.flash_off,
                  _toggleFlash,
                  isActive: _isFlashOn),
            ],
          ),
        ),

        // Bottom controls: gallery · manual capture · switch.
        Positioned(
          bottom: MediaQuery.of(context).padding.bottom + 32.h,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _actionBtn(Icons.photo_library, 'Upload', _pickFromGallery),
              GestureDetector(
                onTap: (_fired || _manualCapturing) ? null : _manualCapture,
                child: Container(
                  width: 74.w,
                  height: 74.w,
                  decoration: BoxDecoration(
                    color: (_fired || _manualCapturing) ? Colors.grey : _kAccent,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: _kAccent.withValues(alpha: 0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 4)),
                    ],
                  ),
                  child: _manualCapturing
                      ? LazerVaultLoader.small()
                      : Icon(Icons.camera_alt, color: Colors.white, size: 30.sp),
                ),
              ),
              _actionBtn(Icons.flip_camera_ios, 'Switch',
                  _cameras.length > 1 ? _switchCamera : null),
            ],
          ),
        ),
      ],
    );
  }

  Widget _circleBtn(IconData icon, VoidCallback? onTap, {bool isActive = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: isActive ? _kAccent : Colors.black.withValues(alpha: 0.5),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 24.sp),
      ),
    );
  }

  Widget _actionBtn(IconData icon, String label, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              color: onTap != null
                  ? Colors.white.withValues(alpha: 0.2)
                  : Colors.white.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon,
                color: onTap != null
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.5),
                size: 26.sp),
          ),
          SizedBox(height: 8.h),
          Text(label,
              style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: onTap != null
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.5),
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildLoadingView() {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LazerVaultLoader.small(),
            SizedBox(height: 16.h),
            Text('Starting camera…',
                style: GoogleFonts.inter(fontSize: 16.sp, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorView() {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Stack(
        children: [
          if (widget.showBack)
            Positioned(
              top: MediaQuery.of(context).padding.top + 12.h,
              left: 4.w,
              child: _circleBtn(Icons.arrow_back, () => Get.back()),
            ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.no_photography_outlined,
                    color: const Color(0xFF9CA3AF), size: 56.sp),
                SizedBox(height: 16.h),
                Text('Camera unavailable',
                    style: GoogleFonts.inter(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                SizedBox(height: 8.h),
                Text(_cameraErrorMsg,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        color: const Color(0xFF9CA3AF),
                        height: 1.4)),
                SizedBox(height: 28.h),
                SizedBox(
                  width: double.infinity,
                  height: 52.h,
                  child: ElevatedButton.icon(
                    onPressed: _isDisposing ? null : _initializeCamera,
                    icon: const Icon(Icons.refresh, color: Colors.white),
                    label: Text('Retry',
                        style: GoogleFonts.inter(
                            fontSize: 15.sp, fontWeight: FontWeight.w600)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _kAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r)),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  height: 52.h,
                  child: OutlinedButton.icon(
                    onPressed: _pickFromGallery,
                    icon: const Icon(Icons.photo_library_outlined,
                        color: Colors.white),
                    label: Text('Upload from device',
                        style: GoogleFonts.inter(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF2D2D2D)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
