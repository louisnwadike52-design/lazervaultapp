import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Opens [url] in a draggable bottom-sheet web view with a title bar, loading
/// indicator, error fallback, and an "open in browser" escape hatch. Used by
/// the Help & Support section for admin-configured links (terms, privacy,
/// support videos, etc.) so content stays a single source of truth on the web.
Future<void> showWebViewBottomSheet(
  BuildContext context, {
  required String url,
  required String title,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _WebViewSheet(url: url, title: title),
  );
}

class _WebViewSheet extends StatefulWidget {
  final String url;
  final String title;
  const _WebViewSheet({required this.url, required this.title});

  @override
  State<_WebViewSheet> createState() => _WebViewSheetState();
}

class _WebViewSheetState extends State<_WebViewSheet> {
  static const _bg = Color(0xFF0A0A0A);
  static const _card = Color(0xFF1F1F1F);
  static const _border = Color(0xFF2D2D2D);
  static const _secondary = Color(0xFF9CA3AF);

  WebViewController? _controller;
  bool _loading = true;
  bool _error = false; // page reached but failed to load (network error)
  bool _unavailable = false; // no usable URL to load at all
  Timer? _loadTimer; // guards against a page that never finishes loading

  @override
  void initState() {
    super.initState();
    final uri = Uri.tryParse(widget.url);
    if (widget.url.trim().isEmpty ||
        uri == null ||
        !(uri.isScheme('http') || uri.isScheme('https'))) {
      _loading = false;
      _unavailable = true;
      return;
    }
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(_bg)
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (_) {
          _loadTimer?.cancel();
          if (mounted) setState(() => _loading = false);
        },
        onWebResourceError: (_) {
          _loadTimer?.cancel();
          if (mounted) {
            setState(() {
              _loading = false;
              _error = true;
            });
          }
        },
      ))
      ..loadRequest(uri);
    // If the page neither finishes nor errors within the window (dead host,
    // captive portal, silently dropped packets), fall back to the error state
    // so the sheet never spins forever.
    _loadTimer = Timer(const Duration(seconds: 20), () {
      if (mounted && _loading) {
        setState(() {
          _loading = false;
          _error = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _loadTimer?.cancel();
    super.dispose();
  }

  Future<void> _openExternally() async {
    final uri = Uri.tryParse(widget.url);
    if (uri == null) return;
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.92,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, _) => Container(
        decoration: BoxDecoration(
          color: _bg,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          border: Border.all(color: _border),
        ),
        child: Column(
          children: [
            // Grabber + title bar
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: _border,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 8.w, 12.h),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.open_in_new, color: _secondary, size: 20.sp),
                    tooltip: 'Open in browser',
                    onPressed: _openExternally,
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: _secondary, size: 22.sp),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: _border),
            Expanded(child: _content()),
          ],
        ),
      ),
    );
  }

  Widget _content() {
    // No usable URL — a graceful empty state (nothing to open in a browser).
    if (_unavailable) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.link_off, color: _secondary, size: 48.sp),
              SizedBox(height: 16.h),
              Text(
                "This page isn't available right now.",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8.h),
              Text(
                'Please check back later.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(color: _secondary, fontSize: 12.5.sp),
              ),
            ],
          ),
        ),
      );
    }
    if (_error || _controller == null) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.cloud_off, color: _secondary, size: 48.sp),
              SizedBox(height: 16.h),
              Text(
                "Couldn't load this page.",
                style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8.h),
              Text(
                'Check your connection and try opening it in your browser.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(color: _secondary, fontSize: 12.5.sp),
              ),
              SizedBox(height: 16.h),
              OutlinedButton.icon(
                onPressed: _openExternally,
                icon: const Icon(Icons.open_in_new, color: Colors.white, size: 18),
                label: Text('Open in browser',
                    style: GoogleFonts.inter(color: Colors.white)),
                style: OutlinedButton.styleFrom(side: const BorderSide(color: _border)),
              ),
            ],
          ),
        ),
      );
    }
    return Stack(
      children: [
        Container(
          color: _card,
          // Give the WebView a vertical-drag recognizer so IT wins the vertical
          // gesture arena — otherwise the enclosing DraggableScrollableSheet
          // swallows the drag and the page content can't be scrolled to the end.
          child: WebViewWidget(
            controller: _controller!,
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
              Factory<VerticalDragGestureRecognizer>(
                  () => VerticalDragGestureRecognizer()),
            },
          ),
        ),
        if (_loading)
          const Center(child: CircularProgressIndicator(color: Color(0xFF6D28D9))),
      ],
    );
  }
}
