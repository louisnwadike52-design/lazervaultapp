import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import '../../data/services/escrow_media_upload_service.dart';
import '../cubit/escrow_cubit.dart';
import '../view/escrow_theme.dart';
import 'escrow_media_viewer.dart';

/// Attaches already-uploaded evidence [items] to [dealId] under [purpose], and
/// returns HOW MANY FAILED to attach (0 means everything landed).
///
/// Still best effort — a failed attach must never roll back a funded deal or
/// block a delivery/dispute action. But the caller has to be TOLD, because
/// `EscrowCubit.addAttachment` catches its own errors and returns false, so
/// previously every failure was discarded here and the user was carried on to
/// the receipt believing their photos and video were attached.
///
/// That silence is expensive in escrow specifically: these attachments are the
/// evidence a dispute is decided on (`deal_item`, `delivery_proof`,
/// `dispute_evidence`). Losing them quietly is worse than a visible warning,
/// because nobody discovers it until the moment it is needed.
///
/// Routed through the cubit so every call rides the repository retry pipeline.
Future<int> attachEscrowMedia({
  required EscrowCubit cubit,
  required String dealId,
  required String purpose,
  required List<EscrowMediaUploadResult> items,
}) async {
  var failed = 0;
  for (final m in items) {
    final ok = await cubit.addAttachment(
      dealId: dealId,
      purpose: purpose,
      mediaKind: m.mediaKind,
      url: m.publicUrl,
      contentType: m.contentType,
      sizeBytes: m.sizeBytes,
      durationSeconds: m.durationSeconds,
    );
    if (!ok) failed++;
  }
  return failed;
}

/// A human message for [failed] evidence items that did not attach, or null
/// when everything landed. Kept here so all four call sites word it the same.
String? escrowAttachWarning(int failed) {
  if (failed <= 0) return null;
  return failed == 1
      ? 'One photo or video could not be attached. You can add it again from the deal.'
      : '$failed photos or videos could not be attached. You can add them again from the deal.';
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

  /// Most photos allowed IN TOTAL on the deal or offer, not just in this
  /// picker. Defaults to the server's own cap — see [kEscrowMaxPhotos].
  final int maxPhotos;

  /// Photos ALREADY attached to this deal/offer by an earlier step.
  ///
  /// The server's six-photo cap is counted across the whole deal, so a picker
  /// opened on a deal that already carries four may only add two. Without
  /// this, the picker happily accepted six more, uploaded every one of them to
  /// storage, and then the server rejected the overflow — the user got
  /// "2 photos could not be attached" after waiting for all six to upload,
  /// with nothing having told them beforehand.
  ///
  /// Zero is correct for the offer builder: nothing is persisted there until
  /// the offer is published.
  final int existingPhotoCount;

  /// A video already attached FOR THIS STEP. Videos are capped per purpose,
  /// and each picker serves one purpose, so this is 0 or 1.
  final int existingVideoCount;

  /// Optional service override (tests). Defaults to the storage-proxy pipeline.
  final EscrowMediaUploadService? service;

  const EscrowAttachmentPicker({
    super.key,
    required this.onChanged,
    this.onError,
    this.maxPhotos = kEscrowMaxPhotos,
    this.existingPhotoCount = 0,
    this.existingVideoCount = 0,
  }) : service = null;

  @override
  State<EscrowAttachmentPicker> createState() => _EscrowAttachmentPickerState();
}

class _EscrowAttachmentPickerState extends State<EscrowAttachmentPicker> {
  late final EscrowMediaUploadService _service =
      widget.service ?? EscrowMediaUploadService(endpoints: endpointRegistry);

  final List<EscrowMediaUploadResult> _items = [];
  bool _busy = false;

  /// Photos on the deal in total: the ones already there plus the ones picked
  /// here. The server counts it this way, so the picker must too.
  int get _photoCount =>
      widget.existingPhotoCount + _items.where((m) => !m.isVideo).length;
  bool get _hasVideo =>
      widget.existingVideoCount >= kEscrowMaxVideosPerStep ||
      _items.any((m) => m.isVideo);

  /// How many more photos this picker may accept. Never negative: a deal that
  /// somehow already exceeds the cap must offer zero, not a negative budget.
  int get _photosRemaining {
    final left = widget.maxPhotos - _photoCount;
    return left > 0 ? left : 0;
  }

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
                  style:
                      GoogleFonts.inter(color: Colors.white, fontSize: 14.sp)),
              onTap: () => Navigator.pop(ctx, ImageSource.camera),
            ),
            ListTile(
              leading: Icon(Icons.collections_outlined,
                  color: EscrowTheme.primary, size: 22.sp),
              title: Text('Choose from library',
                  style:
                      GoogleFonts.inter(color: Colors.white, fontSize: 14.sp)),
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
    if (_photosRemaining == 0) {
      widget.onError?.call(widget.existingPhotoCount > 0
          // Say WHY there is no room, or a user looking at an empty picker is
          // being told they already have six photos they cannot see.
          ? 'This deal already has ${widget.maxPhotos} photos, which is the '
              'most it can carry. Remove one to add another.'
          : 'You can add up to ${widget.maxPhotos} photos.');
      return;
    }
    final source = await _chooseSource();
    if (source == null) return;
    await _run(() => _service.pickAndUploadImage(source: source),
        isVideo: false);
  }

  Future<void> _addVideo() async {
    if (_busy) return;
    if (_hasVideo) {
      widget.onError?.call(widget.existingVideoCount > 0
          ? 'This step already has a video. Remove it to add a different one.'
          : 'You can add one short video.');
      return;
    }
    final source = await _chooseSource();
    if (source == null) return;
    await _run(() => _service.pickAndUploadVideo(source: source),
        isVideo: true);
  }

  Future<void> _run(Future<EscrowMediaUploadResult?> Function() task,
      {required bool isVideo}) async {
    setState(() => _busy = true);
    try {
      final result = await task();
      if (result == null) return;
      // Re-check the cap before appending, not only before picking. The check
      // in _addPhoto ran BEFORE the source sheet and the upload — two long
      // awaits — and this is the only line that actually grows the list, so
      // it is the only place the cap can be enforced with certainty.
      final full = result.isVideo ? _hasVideo : _photosRemaining == 0;
      if (full) {
        widget.onError?.call(result.isVideo
            ? 'You can add one short video.'
            : 'You can add up to ${widget.maxPhotos} photos.');
        return;
      }
      _items.add(result);
      _emit();
    } on EscrowMediaUploadException catch (e) {
      widget.onError?.call(e.message);
    } catch (_) {
      widget.onError?.call(isVideo
          ? 'We could not add that video. Please try again.'
          : 'We could not add that photo. Please try again.');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _remove(EscrowMediaUploadResult m) {
    setState(() => _items.remove(m));
    _emit();
  }

  /// What the user is actually allowed to do RIGHT NOW.
  ///
  /// The old line always read "Add up to 4 photos and one short video", which
  /// was wrong twice over on a deal that already carried media: wrong number,
  /// and it kept inviting a photo after the sixth had been used up.
  String _helperText() {
    final left = _photosRemaining;
    final videoLeft = !_hasVideo;
    if (left == 0 && !videoLeft) {
      return 'This deal has all the photos and video it can carry. '
          'Remove one to swap it for another.';
    }
    final photoPart = left == 0
        ? 'No photo slots left'
        : left == 1
            ? 'Add 1 more photo'
            : 'Add up to $left more photos';
    if (!videoLeft) return '$photoPart. A video is already attached.';
    return '$photoPart and one short video (up to '
        '$kEscrowVideoMaxSeconds seconds).';
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
          _helperText(),
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
    // Shared Hero tag between this tile and the full-screen viewer so tapping a
    // preview expands it out of the grid and collapses back on dismiss. Keyed on
    // publicUrl, which is unique per uploaded item.
    final heroTag = 'escrow-media-${m.publicUrl}';
    return Stack(
      children: [
        // NOT Positioned.fill here. _tileBox is a Container, so a Positioned
        // child lands on a RenderObject that takes BoxParentData, and Flutter
        // throws "Incorrect use of ParentDataWidget". In release that renders
        // the fallback error widget — an unconstrained blank box that stretches
        // the whole form — which is what broke the page the instant the first
        // photo or video thumbnail appeared. The Container already gives the
        // media a tight 84x84 box and clips it, so it just fills it directly.
        _tileBox(
          child: GestureDetector(
            onTap: () => showEscrowMediaViewer(
              context,
              url: m.publicUrl,
              isVideo: m.isVideo,
              heroTag: heroTag,
            ),
            child: Hero(tag: heroTag, child: media),
          ),
        ),
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
