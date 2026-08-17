part of 'p2p_chat_input_bar.dart';

/// Full-screen preview shown after picking an image (camera or gallery) so the
/// user can attach a caption before sending (WhatsApp/iMessage-style). Pops the
/// caption text (possibly empty) on Send, or null on back/cancel.
class _ImageCaptionPreview extends StatefulWidget {
  final String imagePath;
  const _ImageCaptionPreview({required this.imagePath});

  @override
  State<_ImageCaptionPreview> createState() => _ImageCaptionPreviewState();
}

class _ImageCaptionPreviewState extends State<_ImageCaptionPreview> {
  final TextEditingController _caption = TextEditingController();

  @override
  void dispose() {
    _caption.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(), // null = cancel
        ),
        title: Text('Send photo',
            style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp)),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: InteractiveViewer(
                child: Image.file(File(widget.imagePath), fit: BoxFit.contain),
              ),
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 8.h),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _caption,
                      autofocus: false,
                      minLines: 1,
                      maxLines: 4,
                      style: GoogleFonts.inter(
                          color: Colors.white, fontSize: 14.sp),
                      decoration: InputDecoration(
                        hintText: 'Add a caption…',
                        hintStyle: GoogleFonts.inter(
                            color: const Color(0xFF9CA3AF), fontSize: 14.sp),
                        filled: true,
                        fillColor: const Color(0xFF1F1F1F),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24.r),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(_caption.text),
                    child: Container(
                      width: 48.w,
                      height: 48.w,
                      decoration: const BoxDecoration(
                        color: Color(0xFF7C3AED),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.send_rounded,
                          color: Colors.white, size: 22.sp),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
