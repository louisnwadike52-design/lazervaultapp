import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_surfaces.dart';

/// An upload slot that SHOWS what was uploaded.
///
/// WHY THIS REPLACES THE OLD TILE
/// ------------------------------
/// The original showed a green tick and the words "Uploaded — tap to replace", and
/// nothing else. For a government ID that is not enough: the commonest upload
/// mistakes are a blurred photo, a cropped edge, and picking the wrong file from the
/// gallery, and a tick confirms none of those. The user found out days later when
/// compliance rejected it.
///
/// So the thumbnail is the point, and tapping it opens the full image. PDFs cannot
/// be previewed inline, so they show a file card with the extension — an honest
/// "this is a PDF and it uploaded" rather than a fake preview.
class FcyDocumentTile extends StatelessWidget {
  const FcyDocumentTile({
    super.key,
    required this.title,
    required this.description,
    required this.url,
    required this.uploading,
    required this.onPick,
    this.onClear,
  });

  final String title;
  final String description;

  /// Public URL once uploaded. Null or empty means nothing yet.
  final String? url;

  final bool uploading;
  final VoidCallback onPick;
  final VoidCallback? onClear;

  bool get _hasFile => (url ?? '').isNotEmpty;

  /// Whether the URL looks like an image we can render. Checked on the path, before
  /// any query string — a signed URL ends in `?sig=…`, and matching on the whole
  /// string would classify every image as "not an image".
  bool get _isImage {
    final u = url;
    if (u == null || u.isEmpty) return false;
    final path = Uri.tryParse(u)?.path.toLowerCase() ?? u.toLowerCase();
    return path.endsWith('.jpg') ||
        path.endsWith('.jpeg') ||
        path.endsWith('.png') ||
        path.endsWith('.webp') ||
        path.endsWith('.heic');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: AppSurfaces.card(radius: 16, accentAlpha: 0.22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.5.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        description,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.5),
                          fontSize: 12.sp,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
                if (_hasFile && !uploading)
                  Icon(Icons.check_circle_rounded,
                      color: const Color(0xFF10B981), size: 20.sp),
              ],
            ),
            SizedBox(height: 14.h),
            if (uploading)
              _uploadingBox()
            else if (_hasFile)
              _preview(context)
            else
              _emptyPicker(),
          ],
        ),
      ),
    );
  }

  Widget _uploadingBox() => Container(
        height: 120.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 22.w,
              height: 22.w,
              child: CircularProgressIndicator(
                strokeWidth: 2.2,
                valueColor:
                    AlwaysStoppedAnimation(AppSurfaces.accentPurple),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'Uploading…',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 12.5.sp,
              ),
            ),
          ],
        ),
      );

  Widget _emptyPicker() => InkWell(
        onTap: onPick,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          height: 104.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: AppSurfaces.accentPurple.withValues(alpha: 0.3),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_photo_alternate_outlined,
                  color: AppSurfaces.accentPurple, size: 26.sp),
              SizedBox(height: 8.h),
              Text(
                'Choose a photo or PDF',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.75),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );

  Widget _preview(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _isImage ? () => _openFullScreen(context) : null,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: _isImage
                ? Image.network(
                    url!,
                    height: 150.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (_, child, progress) => progress == null
                        ? child
                        : SizedBox(
                            height: 150.h,
                            child: Center(
                              child: SizedBox(
                                width: 20.w,
                                height: 20.w,
                                child: const CircularProgressIndicator(
                                    strokeWidth: 2),
                              ),
                            ),
                          ),
                    // A thumbnail that fails to load must not read as "upload
                    // failed" — the file is on the server either way. It says the
                    // preview is unavailable, which is the truthful statement.
                    errorBuilder: (_, __, ___) => _fileCard('Preview unavailable'),
                  )
                : _fileCard('PDF document'),
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            TextButton.icon(
              onPressed: onPick,
              icon: Icon(Icons.refresh_rounded,
                  size: 16.sp, color: AppSurfaces.accentPurple),
              label: Text(
                'Replace',
                style: TextStyle(
                    color: AppSurfaces.accentPurple, fontSize: 13.sp),
              ),
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            if (onClear != null) ...[
              SizedBox(width: 6.w),
              TextButton.icon(
                onPressed: onClear,
                icon: Icon(Icons.delete_outline_rounded,
                    size: 16.sp, color: Colors.white.withValues(alpha: 0.5)),
                label: Text(
                  'Remove',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 13.sp,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
            if (_isImage) ...[
              const Spacer(),
              Text(
                'Tap to enlarge',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.35),
                  fontSize: 11.sp,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _fileCard(String label) => Container(
        height: 150.h,
        width: double.infinity,
        alignment: Alignment.center,
        color: Colors.white.withValues(alpha: 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.description_outlined,
                size: 34.sp, color: Colors.white.withValues(alpha: 0.5)),
            SizedBox(height: 8.h),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 12.5.sp,
              ),
            ),
          ],
        ),
      );

  /// Full-screen zoomable view, so a user can actually check their own document is
  /// legible before submitting it.
  void _openFullScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            elevation: 0,
            title: Text(title, style: TextStyle(fontSize: 15.sp)),
          ),
          body: Center(
            child: InteractiveViewer(
              minScale: 0.5,
              maxScale: 4,
              child: Image.network(
                url!,
                errorBuilder: (_, __, ___) => Text(
                  'Preview unavailable',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
