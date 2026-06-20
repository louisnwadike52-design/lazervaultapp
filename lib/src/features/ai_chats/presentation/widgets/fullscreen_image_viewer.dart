import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A reusable full-screen image viewer for chat media.
///
/// Supports pinch-zoom / pan via [InteractiveViewer], a shared-element [Hero]
/// transition, and tap- or swipe-down-to-dismiss. Renders a remote URL through
/// [CachedNetworkImage] (with a loading spinner + graceful error placeholder)
/// or a local file path via [Image.file].
///
/// Pass either a remote [mediaUrl] (http/https) or a local file [localPath];
/// the remote URL wins when both are present. Typical call site:
/// `FullScreenImageViewer.open(context, mediaUrl: msg.mediaUrl ?? msg.localMediaPath)`.
class FullScreenImageViewer extends StatelessWidget {
  final String? mediaUrl;
  final String? localPath;

  /// Tag used to drive the [Hero] transition. Should match the source widget's
  /// Hero tag so the image animates between the bubble and the viewer.
  final Object heroTag;

  const FullScreenImageViewer({
    super.key,
    this.mediaUrl,
    this.localPath,
    required this.heroTag,
  });

  /// Convenience that resolves a single [source] into a remote URL or local
  /// path and pushes the viewer as an opaque full-screen route.
  static Future<void> open(
    BuildContext context, {
    String? mediaUrl,
    String? localPath,
    Object? heroTag,
  }) {
    return Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black,
        pageBuilder: (_, __, ___) => FullScreenImageViewer(
          mediaUrl: mediaUrl,
          localPath: localPath,
          heroTag: heroTag ?? (mediaUrl ?? localPath ?? UniqueKey()),
        ),
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  bool get _hasRemote =>
      mediaUrl != null &&
      mediaUrl!.isNotEmpty &&
      (mediaUrl!.startsWith('http://') || mediaUrl!.startsWith('https://'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Tap anywhere (outside the image) to dismiss.
          Positioned.fill(
            child: GestureDetector(
              onTap: () => Navigator.of(context).maybePop(),
              // Swipe-down-to-dismiss: a downward fling pops the route.
              onVerticalDragEnd: (details) {
                if ((details.primaryVelocity ?? 0) > 250) {
                  Navigator.of(context).maybePop();
                }
              },
              child: Center(
                child: Hero(
                  tag: heroTag,
                  child: InteractiveViewer(
                    minScale: 1.0,
                    maxScale: 5.0,
                    child: _buildImage(),
                  ),
                ),
              ),
            ),
          ),
          // Close affordance.
          Positioned(
            top: MediaQuery.of(context).padding.top + 8.h,
            right: 8.w,
            child: GestureDetector(
              onTap: () => Navigator.of(context).maybePop(),
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close, color: Colors.white, size: 22.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    if (_hasRemote) {
      return CachedNetworkImage(
        imageUrl: mediaUrl!,
        fit: BoxFit.contain,
        placeholder: (_, __) => _buildLoading(),
        errorWidget: (_, __, ___) {
          // Remote failed — fall back to the local file if available,
          // otherwise the error placeholder.
          final local = _localFileOrNull();
          if (local != null) {
            return Image.file(
              local,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => _buildError(),
            );
          }
          return _buildError();
        },
      );
    }

    final local = _localFileOrNull();
    if (local != null) {
      return Image.file(
        local,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => _buildError(),
      );
    }

    return _buildError();
  }

  File? _localFileOrNull() {
    if (localPath == null || localPath!.isEmpty) return null;
    try {
      final f = File(localPath!);
      if (f.existsSync()) return f;
    } catch (_) {
      // File access error — treat as absent.
    }
    return null;
  }

  Widget _buildLoading() {
    return const Center(
      child: SizedBox(
        width: 36,
        height: 36,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          color: Color(0xFF9CA3AF),
        ),
      ),
    );
  }

  Widget _buildError() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.broken_image_outlined,
              color: const Color(0xFF9CA3AF), size: 56.sp),
          SizedBox(height: 8.h),
          Text(
            'Image unavailable',
            style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}
