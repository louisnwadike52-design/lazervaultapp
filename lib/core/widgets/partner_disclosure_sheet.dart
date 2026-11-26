import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:lazervault/core/widgets/app_bottom_sheet.dart';

/// A PARTNER DISCLOSURE, IN A SHEET RATHER THAN A WHOLE SCREEN.
///
/// Reading a provider's terms is a glance, not a destination. The full-screen
/// [PartnerWebViewScreen] gives it an app bar, a refresh button, a share menu
/// and an overflow — the furniture of a place you have gone to — and it hides
/// the screen the customer was deciding on. A sheet at 80% keeps the product
/// behind it, so the terms are read ALONGSIDE the decision they are about,
/// and one swipe puts it away.
///
/// ## The navigation cases this handles, because a webview has its own
///
///  * **Back goes back IN THE PAGE first.** A disclosure that links to a
///    privacy policy would otherwise close the whole sheet on the first back
///    press, losing the customer's place. `canPop` is recomputed from the
///    controller after every navigation, so back unwinds the page and only
///    then dismisses.
///  * **Loading is shown, not implied.** A blank sheet reads as broken on a
///    slow connection, which is most of them.
///  * **A failure offers both ways out** — retry, or open in the browser —
///    rather than an empty white box. A compliance surface that cannot be
///    read is not a compliance surface.
///  * **Dismissal always works.** The drag handle and the barrier stay live
///    even mid-load, so a wedged page can never trap anybody.
Future<void> showPartnerDisclosureSheet(
  BuildContext context, {
  required String url,
  required String title,
  double heightFactor = 0.9,
}) {
  return showAppBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _PartnerDisclosureSheet(
      url: url,
      title: title,
      heightFactor: heightFactor,
    ),
  );
}

class _PartnerDisclosureSheet extends StatefulWidget {
  const _PartnerDisclosureSheet({
    required this.url,
    required this.title,
    required this.heightFactor,
  });

  final String url;
  final String title;
  final double heightFactor;

  @override
  State<_PartnerDisclosureSheet> createState() =>
      _PartnerDisclosureSheetState();
}

class _PartnerDisclosureSheetState extends State<_PartnerDisclosureSheet> {
  late final WebViewController _controller;
  bool _loading = true;
  bool _failed = false;
  int _progress = 0;

  /// Whether the PAGE can go back. Recomputed after every navigation rather
  /// than asked during a pop: `canGoBack()` is async and `PopScope.canPop`
  /// is a plain bool, so it has to be known in advance.
  bool _pageCanGoBack = false;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (_) {
          if (!mounted) return;
          setState(() {
            _loading = true;
            _failed = false;
          });
        },
        onProgress: (p) {
          if (!mounted) return;
          setState(() => _progress = p);
        },
        onPageFinished: (_) async {
          final back = await _controller.canGoBack();
          if (!mounted) return;
          setState(() {
            _loading = false;
            _pageCanGoBack = back;
          });
        },
        onWebResourceError: (_) {
          if (!mounted) return;
          setState(() {
            _failed = true;
            _loading = false;
          });
        },
      ))
      ..loadRequest(Uri.parse(widget.url));
  }

  Future<void> _openExternally() async {
    final uri = Uri.tryParse(widget.url);
    if (uri == null) return;
    // Never a thrown platform exception on a device with no browser — the
    // sheet is still readable, and a failed hand-off must not close it.
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {/* stay put */}
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * widget.heightFactor;
    return PopScope(
      // Back unwinds the PAGE before it dismisses the sheet.
      canPop: !_pageCanGoBack,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop || !_pageCanGoBack) return;
        await _controller.goBack();
        final back = await _controller.canGoBack();
        if (mounted) setState(() => _pageCanGoBack = back);
      },
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: const Color(0xFF111111),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Container(
              width: 38.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.22),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 8.w, 8.h),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Open in browser',
                    onPressed: _openExternally,
                    icon: Icon(Icons.open_in_new_rounded,
                        color: Colors.white.withValues(alpha: 0.6),
                        size: 18.sp),
                  ),
                  IconButton(
                    tooltip: 'Close',
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: Icon(Icons.close_rounded,
                        color: Colors.white.withValues(alpha: 0.75),
                        size: 20.sp),
                  ),
                ],
              ),
            ),
            if (_loading && !_failed)
              LinearProgressIndicator(
                value: _progress <= 0 ? null : _progress / 100,
                minHeight: 2.h,
                backgroundColor: Colors.white.withValues(alpha: 0.06),
                valueColor: const AlwaysStoppedAnimation(Color(0xFF4E03D0)),
              ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20.r)),
                child: _failed
                    ? _ErrorBody(
                        onRetry: () => _controller.reload(),
                        onOpen: _openExternally,
                      )
                    : WebViewWidget(
                        controller: _controller,
                        // THE SHEET MUST NOT EAT THE PAGE'S SCROLL.
                        //
                        // A modal bottom sheet claims vertical drags for its
                        // own dismiss gesture, and the platform view only
                        // receives what the Flutter arena hands it. Without
                        // this the disclosure rendered fine and would not
                        // scroll: a drag inside the page dragged the SHEET,
                        // so everything below the first screenful was
                        // unreachable — on the one surface whose whole
                        // purpose is to be read to the end.
                        //
                        // Eager, so the web view wins the vertical drag
                        // immediately rather than after the arena resolves.
                        // The drag handle and the barrier still dismiss, so
                        // nothing is trapped.
                        gestureRecognizers: {
                          Factory<VerticalDragGestureRecognizer>(
                              VerticalDragGestureRecognizer.new),
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorBody extends StatelessWidget {
  const _ErrorBody({required this.onRetry, required this.onOpen});

  final VoidCallback onRetry;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(28.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.wifi_off_rounded,
                color: Colors.white.withValues(alpha: 0.5), size: 34.sp),
            SizedBox(height: 14.h),
            Text(
              'We could not load this just now.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                  color: Colors.white, fontSize: 14.sp,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 6.h),
            Text(
              'Check your connection and try again, or open it in your browser.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.6), fontSize: 12.sp),
            ),
            SizedBox(height: 18.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: onOpen, child: const Text('Open in browser')),
                SizedBox(width: 8.w),
                ElevatedButton(
                  onPressed: onRetry,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4E03D0),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r)),
                  ),
                  child: const Text('Try again'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
