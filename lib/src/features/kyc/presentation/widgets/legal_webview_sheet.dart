import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Opens a legal document (Terms of Service / Privacy Policy) in a themed in-app
/// WebView, presented as a bottom sheet at 85% of the screen height. The URL is
/// supplied by the caller and is admin-configurable.
Future<void> showLegalWebViewSheet(
  BuildContext context, {
  required String title,
  required String url,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => LegalWebViewSheet(title: title, url: url),
  );
}

class LegalWebViewSheet extends StatefulWidget {
  final String title;
  final String url;
  const LegalWebViewSheet({super.key, required this.title, required this.url});

  @override
  State<LegalWebViewSheet> createState() => _LegalWebViewSheetState();
}

class _LegalWebViewSheetState extends State<LegalWebViewSheet> {
  static const _indigo = Color(0xFF6366F1);
  late final WebViewController _controller;
  bool _loading = true;
  bool _error = false;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            if (mounted) setState(() => _loading = false);
          },
          onWebResourceError: (_) {
            if (mounted) setState(() => _error = true);
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.85,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 8.w, 12.h),
              child: Row(
                children: [
                  Container(
                    width: 36.w,
                    height: 36.w,
                    decoration: BoxDecoration(
                      color: _indigo.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.description_outlined,
                        color: _indigo, size: 18.sp),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF111827),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: Color(0xFF6B7280)),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Color(0xFFE5E7EB)),
            Expanded(
              child: _error
                  ? _buildError()
                  : Stack(
                      children: [
                        ClipRRect(
                          borderRadius:
                              BorderRadius.vertical(bottom: Radius.circular(20.r)),
                          child: WebViewWidget(controller: _controller),
                        ),
                        if (_loading)
                          const Center(
                            child: CircularProgressIndicator(color: _indigo),
                          ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.wifi_off_rounded, color: const Color(0xFF9CA3AF), size: 36.sp),
            SizedBox(height: 12.h),
            Text(
              'Couldn\'t load this page. Please check your connection and try again.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                  color: const Color(0xFF6B7280), fontSize: 13.sp),
            ),
          ],
        ),
      ),
    );
  }
}
