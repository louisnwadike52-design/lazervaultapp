part of 'live_scan_camera_view.dart';

/// Dim overlay + a single purple viewfinder (the aim guide). The viewfinder IS
/// the OCR region now — line the bank details up anywhere inside the box and ML
/// Kit reads them automatically (no separate detection band).
class CameraOverlayPainter extends CustomPainter {
  const CameraOverlayPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withValues(alpha: 0.5)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = _kAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    final viewfinderWidth = size.width * 0.8;
    final viewfinderHeight = viewfinderWidth * 1.2;
    final left = (size.width - viewfinderWidth) / 2;
    final top = (size.height - viewfinderHeight) / 2;
    final viewfinderRect =
        Rect.fromLTWH(left, top, viewfinderWidth, viewfinderHeight);

    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(
          RRect.fromRectAndRadius(viewfinderRect, const Radius.circular(20)));
    path.fillType = PathFillType.evenOdd;
    canvas.drawPath(path, paint);

    canvas.drawRRect(
      RRect.fromRectAndRadius(viewfinderRect, const Radius.circular(20)),
      borderPaint,
    );

    final cornerPaint = Paint()
      ..color = _kAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    const cornerLength = 20.0;
    const cornerRadius = 20.0;

    // Top-left
    canvas.drawLine(Offset(left + cornerRadius, top),
        Offset(left + cornerRadius + cornerLength, top), cornerPaint);
    canvas.drawLine(Offset(left, top + cornerRadius),
        Offset(left, top + cornerRadius + cornerLength), cornerPaint);
    // Top-right
    canvas.drawLine(
        Offset(left + viewfinderWidth - cornerRadius - cornerLength, top),
        Offset(left + viewfinderWidth - cornerRadius, top),
        cornerPaint);
    canvas.drawLine(Offset(left + viewfinderWidth, top + cornerRadius),
        Offset(left + viewfinderWidth, top + cornerRadius + cornerLength),
        cornerPaint);
    // Bottom-left
    canvas.drawLine(
        Offset(left, top + viewfinderHeight - cornerRadius - cornerLength),
        Offset(left, top + viewfinderHeight - cornerRadius),
        cornerPaint);
    canvas.drawLine(Offset(left + cornerRadius, top + viewfinderHeight),
        Offset(left + cornerRadius + cornerLength, top + viewfinderHeight),
        cornerPaint);
    // Bottom-right
    canvas.drawLine(
        Offset(left + viewfinderWidth,
            top + viewfinderHeight - cornerRadius - cornerLength),
        Offset(left + viewfinderWidth, top + viewfinderHeight - cornerRadius),
        cornerPaint);
    canvas.drawLine(
        Offset(left + viewfinderWidth - cornerRadius - cornerLength,
            top + viewfinderHeight),
        Offset(left + viewfinderWidth - cornerRadius, top + viewfinderHeight),
        cornerPaint);

    // (Removed the separate green detection band — OCR now reads the whole
    // viewfinder region, so the single purple frame IS the aim guide. Line the
    // bank details up anywhere inside the box and it reads them automatically.)
  }

  @override
  bool shouldRepaint(covariant CameraOverlayPainter oldDelegate) => false;
}

/// A tightly-packed, cropped single-plane image buffer for ML Kit (Y+VU for
/// NV21, BGRA for iOS) produced by `_croppedRoi`.
class _RoiBuffer {
  const _RoiBuffer(this.bytes, this.width, this.height, this.bytesPerRow);

  final Uint8List bytes;
  final int width;
  final int height;
  final int bytesPerRow;
}
