import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gal/gal.dart';
import 'package:http/http.dart' as http;

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
class FullScreenImageViewer extends StatefulWidget {
  final String? mediaUrl;
  final String? localPath;

  /// Tag used to drive the [Hero] transition. Should match the source widget's
  /// Hero tag so the image animates between the source and the viewer.
  final Object heroTag;

  const FullScreenImageViewer({
    super.key,
    this.mediaUrl,
    this.localPath,
    required this.heroTag,
  });

  /// Convenience that resolves a single source into a remote URL or local
  /// path and pushes the viewer as a transparent full-screen route (so the
  /// drag-to-dismiss can fade the backdrop and reveal the screen behind).
  static Future<void> open(
    BuildContext context, {
    String? mediaUrl,
    String? localPath,
    Object? heroTag,
  }) {
    return Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        // Backdrop opacity is painted by the widget itself so it can fade with
        // the drag — no fixed barrier here.
        barrierColor: Colors.transparent,
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

  @override
  State<FullScreenImageViewer> createState() => _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<FullScreenImageViewer>
    with SingleTickerProviderStateMixin {
  // Detects pinch-zoom so drag-to-dismiss is disabled while zoomed (pan wins).
  final TransformationController _transform = TransformationController();
  late final AnimationController _snap;
  // Vertical drag offset of the image (0 = centred / at rest).
  double _dy = 0;

  // Distance to travel before a release dismisses (else it snaps back).
  static const double _dismissThreshold = 140;

  // True while a save-to-gallery is in flight (shows a spinner, blocks re-taps).
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _snap = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _transform.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _snap.dispose();
    _transform.dispose();
    super.dispose();
  }

  bool get _hasRemote =>
      widget.mediaUrl != null &&
      widget.mediaUrl!.isNotEmpty &&
      (widget.mediaUrl!.startsWith('http://') ||
          widget.mediaUrl!.startsWith('https://'));

  bool get _isZoomed => _transform.value.getMaxScaleOnAxis() > 1.02;

  // 0 → 1 as the image is dragged toward the dismiss threshold.
  double get _progress => (_dy.abs() / (_dismissThreshold * 2)).clamp(0.0, 1.0);
  double get _imageScale => 1 - _progress * 0.25; // shrink slightly while dragging
  double get _backdropOpacity => 1 - _progress * 0.9; // fade the black backdrop

  void _onDragUpdate(DragUpdateDetails d) {
    if (_isZoomed) return; // let InteractiveViewer pan when zoomed
    setState(() => _dy += d.delta.dy);
  }

  void _onDragEnd(DragEndDetails d) {
    if (_isZoomed) return;
    final v = d.primaryVelocity ?? 0;
    // Past the threshold OR a fast fling → dismiss (Hero animates back to the
    // source position). Otherwise snap the image back to centre.
    if (_dy.abs() > _dismissThreshold || v.abs() > 700) {
      // Reset to centre so the Hero flies from the source's layout rect, then
      // pop in the same frame — the Hero transition carries it back to place.
      setState(() => _dy = 0);
      Navigator.of(context).maybePop();
      return;
    }
    final anim = Tween<double>(begin: _dy, end: 0).animate(
      CurvedAnimation(parent: _snap, curve: Curves.easeOutCubic),
    );
    void listener() => setState(() => _dy = anim.value);
    _snap
      ..removeListener(listener)
      ..reset()
      ..addListener(listener);
    _snap.forward();
  }

  // Whether there's any savable image source (remote URL or an on-disk file).
  bool get _canSave => _hasRemote || _localFileOrNull() != null;

  void _toast(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF1F1F1F),
      ),
    );
  }

  /// Save the currently-shown image to the device photo gallery. Downloads the
  /// bytes for a remote URL, or copies the local file. Gal handles the OS
  /// permission prompt (iOS Photos add / Android scoped storage); a denied
  /// grant surfaces an actionable message instead of failing silently.
  Future<void> _saveImage() async {
    if (_saving) return;
    setState(() => _saving = true);
    try {
      const album = 'Lazervault';
      if (_hasRemote) {
        final resp = await http
            .get(Uri.parse(widget.mediaUrl!))
            .timeout(const Duration(seconds: 30));
        if (resp.statusCode < 200 ||
            resp.statusCode >= 300 ||
            resp.bodyBytes.isEmpty) {
          throw 'download failed (HTTP ${resp.statusCode})';
        }
        await Gal.putImageBytes(resp.bodyBytes, album: album);
      } else {
        final local = _localFileOrNull();
        if (local == null) throw 'no image to save';
        await Gal.putImage(local.path, album: album);
      }
      _toast('Saved to your photos');
    } on GalException catch (e) {
      _toast(e.type == GalExceptionType.accessDenied
          ? 'Allow photo access in Settings to save images'
          : 'Could not save the image');
    } catch (_) {
      _toast('Could not save the image. Please try again.');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Dynamic black backdrop that fades as you drag the image away.
          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                color: Colors.black.withValues(alpha: _backdropOpacity),
              ),
            ),
          ),
          // Tap anywhere (outside the image) to dismiss; drag to swipe-dismiss.
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.of(context).maybePop(),
              onVerticalDragUpdate: _onDragUpdate,
              onVerticalDragEnd: _onDragEnd,
              child: Center(
                child: Transform.translate(
                  offset: Offset(0, _dy),
                  child: Transform.scale(
                    scale: _imageScale,
                    child: Hero(
                      tag: widget.heroTag,
                      child: InteractiveViewer(
                        transformationController: _transform,
                        minScale: 1.0,
                        maxScale: 5.0,
                        child: _buildImage(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Save-to-gallery affordance (top-left) — fades with the drag. Hidden
          // when there's no savable source. Shows a spinner while saving.
          if (_canSave)
            Positioned(
              top: MediaQuery.of(context).padding.top + 8.h,
              left: 8.w,
              child: Opacity(
                opacity: _backdropOpacity,
                child: GestureDetector(
                  onTap: _saving ? null : _saveImage,
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: _saving
                        ? SizedBox(
                            width: 22.sp,
                            height: 22.sp,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2.2,
                              color: Colors.white,
                            ),
                          )
                        : Icon(Icons.download_rounded,
                            color: Colors.white, size: 22.sp),
                  ),
                ),
              ),
            ),
          // Close affordance (cancel) — fades out as the image is dragged away.
          Positioned(
            top: MediaQuery.of(context).padding.top + 8.h,
            right: 8.w,
            child: Opacity(
              opacity: _backdropOpacity,
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
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    if (_hasRemote) {
      return CachedNetworkImage(
        imageUrl: widget.mediaUrl!,
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
    if (widget.localPath == null || widget.localPath!.isEmpty) return null;
    try {
      final f = File(widget.localPath!);
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
