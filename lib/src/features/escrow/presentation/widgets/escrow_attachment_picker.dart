import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import '../../data/services/escrow_media_upload_service.dart';
import '../cubit/escrow_cubit.dart';
import '../view/escrow_theme.dart';

/// Attaches already-uploaded evidence [items] to [dealId] under [purpose].
/// Best effort: skips failures so the surrounding action still completes.
/// Routed through the cubit so every call rides the repository retry pipeline.
Future<void> attachEscrowMedia({
  required EscrowCubit cubit,
  required String dealId,
  required String purpose,
  required List<EscrowMediaUploadResult> items,
}) async {
  for (final m in items) {
    await cubit.addAttachment(
      dealId: dealId,
      purpose: purpose,
      mediaKind: m.mediaKind,
      url: m.publicUrl,
      contentType: m.contentType,
      sizeBytes: m.sizeBytes,
      durationSeconds: m.durationSeconds,
    );
  }
}

/// A reusable evidence picker: the user can add several photos and one short
/// video. Each pick is validated, compressed and uploaded to storage straight
/// away, so the parent receives ready-to-attach [EscrowMediaUploadResult]s via
/// [onChanged]. The caller decides when to call `addAttachment` (usually right
/// before the matching action, e.g. mark delivered / request refund) so we
/// never leave orphan attachments behind if a sheet is dismissed.
class EscrowAttachmentPicker extends StatefulWidget {
  /// Called whenever the set of uploaded media changes.
  final ValueChanged<List<EscrowMediaUploadResult>> onChanged;

  /// Surfaces a friendly error (e.g. "please compress it") to the parent.
  final ValueChanged<String>? onError;

  /// Most photos allowed. Videos are always capped at one.
  final int maxPhotos;

  /// Optional service override (tests). Defaults to the storage-proxy pipeline.
  final EscrowMediaUploadService? service;

  const EscrowAttachmentPicker({
    super.key,
    required this.onChanged,
    this.onError,
    this.maxPhotos = 4,
  }) : service = null;

  @override
  State<EscrowAttachmentPicker> createState() => _EscrowAttachmentPickerState();
}

class _EscrowAttachmentPickerState extends State<EscrowAttachmentPicker> {
  late final EscrowMediaUploadService _service =
      widget.service ?? EscrowMediaUploadService(endpoints: endpointRegistry);

  final List<EscrowMediaUploadResult> _items = [];
  bool _busy = false;

  int get _photoCount => _items.where((m) => !m.isVideo).length;
  bool get _hasVideo => _items.any((m) => m.isVideo);

  void _emit() => widget.onChanged(List.unmodifiable(_items));

  Future<ImageSource?> _chooseSource() {
    return showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: EscrowTheme.card,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(18.r))),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 8.h),
            ListTile(
              leading: Icon(Icons.photo_camera_outlined,
                  color: EscrowTheme.primary, size: 22.sp),
              title: Text('Take with camera',
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp)),
              onTap: () => Navigator.pop(ctx, ImageSource.camera),
            ),
            ListTile(
              leading: Icon(Icons.collections_outlined,
                  color: EscrowTheme.primary, size: 22.sp),
              title: Text('Choose from library',
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp)),
              onTap: () => Navigator.pop(ctx, ImageSource.gallery),
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }

  Future<void> _addPhoto() async {
    if (_busy) return;
    if (_photoCount >= widget.maxPhotos) {
      widget.onError?.call('You can add up to ${widget.maxPhotos} photos.');
      return;
    }
    final source = await _chooseSource();
    if (source == null) return;
    await _run(() => _service.pickAndUploadImage(source: source));
  }

  Future<void> _addVideo() async {
    if (_busy) return;
    if (_hasVideo) {
      widget.onError?.call('You can add one short video.');
      return;
    }
    final source = await _chooseSource();
    if (source == null) return;
    await _run(() => _service.pickAndUploadVideo(source: source));
  }

  Future<void> _run(Future<EscrowMediaUploadResult?> Function() task) async {
    setState(() => _busy = true);
    try {
      final result = await task();
      if (result != null) {
        _items.add(result);
        _emit();
      }
    } on EscrowMediaUploadException catch (e) {
      widget.onError?.call(e.message);
    } catch (_) {
      widget.onError?.call('We could not add that. Please try again.');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _remove(EscrowMediaUploadResult m) {
    setState(() => _items.remove(m));
    _emit();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            for (final m in _items) _thumb(m),
            if (_busy) _busyTile(),
            _addTile(
              icon: Icons.add_a_photo_outlined,
              label: 'Photo',
              onTap: _addPhoto,
            ),
            _addTile(
              icon: Icons.videocam_outlined,
              label: 'Video',
              onTap: _addVideo,
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          'Add up to ${widget.maxPhotos} photos and one short video (up to 60 seconds).',
          style: GoogleFonts.inter(
              color: EscrowTheme.textSecondary, fontSize: 11.sp),
        ),
      ],
    );
  }

  Widget _tileBox({required Widget child}) => Container(
        width: 84.w,
        height: 84.w,
        decoration: BoxDecoration(
          color: EscrowTheme.bg,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: EscrowTheme.border),
        ),
        clipBehavior: Clip.antiAlias,
        child: child,
      );

  Widget _addTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: _tileBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: EscrowTheme.primary, size: 22.sp),
            SizedBox(height: 6.h),
            Text(label,
                style: GoogleFonts.inter(
                    color: EscrowTheme.textSecondary, fontSize: 11.sp)),
          ],
        ),
      ),
    );
  }

  Widget _busyTile() => _tileBox(
        child: const Center(
          child: SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
                color: EscrowTheme.primary, strokeWidth: 2),
          ),
        ),
      );

  Widget _thumb(EscrowMediaUploadResult m) {
    final Widget media = m.isVideo
        ? Container(
            color: Colors.black,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.play_circle_outline,
                    color: Colors.white, size: 26.sp),
                if (m.durationSeconds > 0) ...[
                  SizedBox(height: 2.h),
                  Text('${m.durationSeconds}s',
                      style: GoogleFonts.inter(
                          color: Colors.white70, fontSize: 10.sp)),
                ],
              ],
            ),
          )
        : Image.network(
            m.publicUrl,
            fit: BoxFit.cover,
            errorBuilder: (c, e, s) => Container(
              color: EscrowTheme.card,
              alignment: Alignment.center,
              child: Icon(Icons.broken_image_outlined,
                  color: EscrowTheme.textSecondary, size: 20.sp),
            ),
          );
    return Stack(
      children: [
        _tileBox(child: Positioned.fill(child: media)),
        Positioned(
          top: 2.h,
          right: 2.w,
          child: GestureDetector(
            onTap: () => _remove(m),
            child: CircleAvatar(
              radius: 11.r,
              backgroundColor: Colors.black54,
              child: Icon(Icons.close, size: 13.sp, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
