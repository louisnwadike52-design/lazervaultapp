import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Bottom sheet with WebView for DirectPay one-time authorization.
///
/// Opens [paymentUrl] in an in-app WebView and detects completion
/// via Mono's redirect URL callback.
Future<bool> showDirectPayAuthorizationSheet({
  required BuildContext context,
  required String paymentUrl,
  Duration timeout = const Duration(minutes: 5),
}) async {
  final result = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    isDismissible: false,
    enableDrag: false,
    backgroundColor: const Color(0xFF0A0A0A),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
    ),
    builder: (context) => _DirectPayWebViewSheet(
      paymentUrl: paymentUrl,
      timeout: timeout,
    ),
  );
  return result ?? false;
}

class _DirectPayWebViewSheet extends StatefulWidget {
  final String paymentUrl;
  final Duration timeout;

  const _DirectPayWebViewSheet({
    required this.paymentUrl,
    required this.timeout,
  });

  @override
  State<_DirectPayWebViewSheet> createState() => _DirectPayWebViewSheetState();
}

class _DirectPayWebViewSheetState extends State<_DirectPayWebViewSheet> {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _hasTimedOut = false;
  bool _hasCompleted = false;
  Timer? _timeoutTimer;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            if (mounted) setState(() => _isLoading = true);
          },
          onPageFinished: (_) {
            if (mounted) setState(() => _isLoading = false);
          },
          onNavigationRequest: (request) {
            final url = request.url.toLowerCase();
            // Detect Mono callback/redirect URLs
            if (url.contains('lazervault://') ||
                url.contains('mono-success') ||
                url.contains('payment_successful') ||
                url.contains('payment-successful')) {
              _handleSuccess();
              return NavigationDecision.prevent;
            }
            if (url.contains('payment_failed') ||
                url.contains('payment-failed') ||
                url.contains('mono-failure')) {
              _handleFailure();
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onWebResourceError: (_) {
            // Ignore resource errors — page may still work
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));

    // Start timeout timer
    _timeoutTimer = Timer(widget.timeout, () {
      if (mounted && !_hasCompleted) {
        setState(() => _hasTimedOut = true);
      }
    });
  }

  /// The ONE way this sheet closes.
  ///
  /// Every exit has to come through here, because a second pop does not close
  /// the sheet again — it closes the screen UNDERNEATH, and the user is left
  /// staring at an empty navigator. A snackbar is a global overlay, so it
  /// survives that and renders over the void: a black screen with an orange
  /// warning floating on it, which is exactly what was reported from the
  /// field after a Direct Debit setup on ALAT by WEMA.
  ///
  /// Two ways that happened. The close button popped unguarded, so a
  /// double-tap popped twice. And the webview outlives the route during the
  /// exit animation — so a redirect arriving just after the user dismissed
  /// the sheet called back in and popped again.
  void _close(bool result) {
    if (_hasCompleted || !mounted) return;
    _hasCompleted = true;
    _timeoutTimer?.cancel();
    Navigator.of(context).pop(result);
  }

  void _handleSuccess() => _close(true);

  void _handleFailure() => _close(false);

  @override
  void dispose() {
    // Anything still in flight is now aimed at a dead route.
    _hasCompleted = true;
    _timeoutTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // isDismissible/enableDrag cover the scrim and the drag handle; the
    // Android back button and the iOS back-swipe pop a modal sheet regardless.
    // Leaving is legitimate here — the NIBSS method needs the user in their
    // own banking app — so the pop is allowed, but it must be RECORDED, or a
    // redirect landing a moment later pops a second time and takes the screen
    // underneath with it.
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) _hasCompleted = true;
      },
      child: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: const BoxDecoration(
              color: Color(0xFF1F1F1F),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                Icon(Icons.lock_outline, color: const Color(0xFF3B82F6), size: 20.sp),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'Authorize Payment',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _close(false),
                  child: Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D2D2D),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Icon(
                      Icons.close,
                      color: const Color(0xFF9CA3AF),
                      size: 18.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Loading indicator
          if (_isLoading)
            const LinearProgressIndicator(
              color: Color(0xFF3B82F6),
              backgroundColor: Color(0xFF2D2D2D),
            ),

          // Timeout banner
          if (_hasTimedOut)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              color: const Color(0xFFFB923C).withValues(alpha: 0.15),
              child: Row(
                children: [
                  Icon(Icons.timer_off, color: const Color(0xFFFB923C), size: 16.sp),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'Authorization timed out. Close and try again.',
                      style: GoogleFonts.inter(
                        color: const Color(0xFFFB923C),
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // WebView
          Expanded(
            child: WebViewWidget(
              controller: _controller,
              // Claim vertical drags so the page scrolls to its end inside the
              // bottom sheet (otherwise the sheet swallows the scroll gesture).
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                Factory<VerticalDragGestureRecognizer>(
                    () => VerticalDragGestureRecognizer()),
              },
            ),
          ),
        ],
      ),
    );
  }
}
