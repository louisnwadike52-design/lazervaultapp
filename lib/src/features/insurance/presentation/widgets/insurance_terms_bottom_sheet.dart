// Insurance Terms & Conditions — in-app webview bottom sheet.
//
// The terms link is admin-editable (system_settings.insurance.mycover.
// terms_link, set from the Configuration tab on the admin dashboard).
// Flutter receives it via GetInsuranceMarketplaceCategories.terms_link.
//
// The sheet:
//   • opens immediately with chrome + a loading state
//   • resolves the URL via the supplied [urlResolver] (lets the caller
//     hit the backend lazily and surface errors inside the sheet)
//   • renders the page in an embedded WebView pinned to a Chrome-on-
//     Android UA so the hosted page serves the same HTML a real browser
//     would
//   • handles three failure modes inside the sheet (no toast theatre):
//       - resolver threw           → "We couldn't open Terms" + Retry
//       - resolver returned null   → "Terms unavailable" + Close
//       - page error in WebView    → in-line error + Retry + Browser
//
// 80% screen height per the design spec. Themed to the app's dark
// palette so it doesn't look like a popup.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

class InsuranceTermsBottomSheet extends StatefulWidget {
  const InsuranceTermsBottomSheet({super.key, required this.urlResolver});

  /// Async resolver that returns the admin-set terms URL. Return `null`
  /// to signal "no link configured"; throw to signal a real error.
  final Future<String?> Function() urlResolver;

  static Future<void> show(
    BuildContext context, {
    required Future<String?> Function() urlResolver,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      barrierColor: Colors.black.withValues(alpha: 0.6),
      builder: (_) => InsuranceTermsBottomSheet(urlResolver: urlResolver),
    );
  }

  @override
  State<InsuranceTermsBottomSheet> createState() => _InsuranceTermsBottomSheetState();
}

class _InsuranceTermsBottomSheetState extends State<InsuranceTermsBottomSheet> {
  // Pinned modern Chrome UA so providers that user-agent-sniff serve
  // the mobile HTML they'd send a real browser instead of a stripped
  // WebView page.
  static const String _kModernUA =
      'Mozilla/5.0 (Linux; Android 14; Pixel 9a) '
      'AppleWebKit/537.36 (KHTML, like Gecko) '
      'Chrome/137.0.0.0 Mobile Safari/537.36';

  late final WebViewController _controller;
  bool _loadingPage = true;
  int _progress = 0;
  bool _pageFailed = false;
  String? _pageErrorMessage;

  // Resolver state
  bool _resolving = true;
  String? _resolvedUrl;
  bool _linkUnavailable = false;
  String? _resolverError;

  @override
  void initState() {
    super.initState();
    _initController();
    _resolveAndLoad();
  }

  void _initController() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent(_kModernUA)
      ..setBackgroundColor(const Color(0xFF1F1F1F))
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (p) {
          if (!mounted) return;
          setState(() => _progress = p);
        },
        onPageStarted: (_) {
          if (!mounted) return;
          setState(() {
            _loadingPage = true;
            _pageFailed = false;
            _pageErrorMessage = null;
          });
        },
        onPageFinished: (_) {
          if (!mounted) return;
          setState(() => _loadingPage = false);
        },
        onWebResourceError: (err) {
          if (!mounted) return;
          if (err.isForMainFrame == false) return;
          setState(() {
            _loadingPage = false;
            _pageFailed = true;
            _pageErrorMessage = err.description.isNotEmpty
                ? err.description
                : "We couldn't load the terms page. Check your connection and try again.";
          });
        },
        onHttpError: (err) {
          if (!mounted) return;
          if (err.response?.uri == null) return;
          setState(() {
            _loadingPage = false;
            _pageFailed = true;
            _pageErrorMessage = 'The terms page returned an error '
                '(${err.response?.statusCode}). Try again shortly.';
          });
        },
      ));
  }

  Future<void> _resolveAndLoad() async {
    setState(() {
      _resolving = true;
      _linkUnavailable = false;
      _resolverError = null;
    });
    try {
      final url = await widget.urlResolver();
      if (!mounted) return;
      if (url == null || url.trim().isEmpty) {
        setState(() {
          _resolving = false;
          _linkUnavailable = true;
        });
        return;
      }
      _resolvedUrl = url.trim();
      setState(() => _resolving = false);
      final uri = Uri.tryParse(_resolvedUrl!);
      if (uri == null) {
        setState(() {
          _pageFailed = true;
          _pageErrorMessage = 'The configured terms URL is not valid.';
        });
        return;
      }
      _controller.loadRequest(uri);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _resolving = false;
        _resolverError = e.toString();
      });
    }
  }

  Future<void> _openInBrowser() async {
    final url = _resolvedUrl;
    if (url == null || url.isEmpty) return;
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: mq.viewInsets.bottom),
      child: Container(
        height: mq.size.height * 0.80,
        decoration: const BoxDecoration(
          color: Color(0xFF1F1F1F),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            _buildDragHandle(),
            _buildHeader(context),
            if (_loadingPage && !_resolving && _resolvedUrl != null && !_pageFailed)
              _buildProgressBar(),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildDragHandle() => Padding(
        padding: EdgeInsets.only(top: 8.h),
        child: Container(
          width: 36.w,
          height: 4.h,
          decoration: BoxDecoration(
            color: const Color(0xFF2D2D2D),
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
      );

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 8.w, 12.h),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(Icons.gavel_rounded,
                color: const Color(0xFF6366F1), size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Terms & Conditions',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Please review before continuing',
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
          if (_resolvedUrl != null && !_pageFailed)
            IconButton(
              icon: Icon(Icons.refresh_rounded,
                  color: const Color(0xFF9CA3AF), size: 20.sp),
              tooltip: 'Reload',
              onPressed: () => _controller.reload(),
            ),
          IconButton(
            icon: Icon(Icons.close_rounded,
                color: const Color(0xFF9CA3AF), size: 20.sp),
            tooltip: 'Close',
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return LinearProgressIndicator(
      value: _progress > 0 ? _progress / 100.0 : null,
      minHeight: 2.h,
      backgroundColor: const Color(0xFF2D2D2D),
      valueColor: const AlwaysStoppedAnimation(Color(0xFF6366F1)),
    );
  }

  Widget _buildBody() {
    if (_resolving) {
      return _centered(
        LazerVaultLoader.small(),
        title: 'Loading terms',
        subtitle: 'Fetching the latest version…',
      );
    }
    if (_resolverError != null) {
      return _buildErrorState(
        title: "Couldn't load Terms",
        message: 'We had trouble reaching the terms service. '
            'Please check your connection and try again.',
        onRetry: _resolveAndLoad,
      );
    }
    if (_linkUnavailable) {
      return _buildErrorState(
        title: 'Terms unavailable',
        message:
            "The insurance terms link hasn't been configured yet. "
            'Please reach out to support if this is unexpected.',
        onRetry: _resolveAndLoad,
        retryLabel: 'Try again',
      );
    }
    if (_pageFailed) {
      return _buildErrorState(
        title: "Couldn't open Terms",
        message: _pageErrorMessage ??
            'The terms page failed to load. Try again, or open it in your browser.',
        onRetry: () {
          final uri = Uri.tryParse(_resolvedUrl ?? '');
          if (uri != null) _controller.loadRequest(uri);
        },
        secondaryAction: _resolvedUrl != null
            ? _SecondaryAction(label: 'Open in browser', onTap: _openInBrowser)
            : null,
      );
    }
    return WebViewWidget(controller: _controller);
  }

  Widget _centered(Widget icon, {required String title, String? subtitle}) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            SizedBox(height: 16.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            if (subtitle != null) ...[
              SizedBox(height: 6.h),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState({
    required String title,
    required String message,
    required VoidCallback onRetry,
    String retryLabel = 'Retry',
    _SecondaryAction? secondaryAction,
  }) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444).withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.error_outline_rounded,
                  color: const Color(0xFFEF4444), size: 28.sp),
            ),
            SizedBox(height: 14.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                color: const Color(0xFF9CA3AF),
                height: 1.4,
              ),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6366F1),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Text(
                  retryLabel,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            if (secondaryAction != null) ...[
              SizedBox(height: 10.h),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: secondaryAction.onTap,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF6366F1),
                    side: const BorderSide(color: Color(0xFF6366F1)),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    secondaryAction.label,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SecondaryAction {
  final String label;
  final VoidCallback onTap;
  const _SecondaryAction({required this.label, required this.onTap});
}
