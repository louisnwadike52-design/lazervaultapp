import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

/// Makes `<input type="file">` work inside an Android WebView.
///
/// ## The dead button
///
/// Android's WebView does not open a file picker by itself. When a page
/// triggers a file input it calls `onShowFileChooser` on the host app, and
/// `webview_flutter_android` routes that to `setOnShowFileSelector`. **If no
/// callback is registered the tap does nothing at all** — no picker, no error,
/// no feedback of any kind. The button simply does not respond.
///
/// Nothing in this app registered one, so every file input in every WebView
/// was inert on Android. The one that matters is Mono's identity flow: its
/// documentary-verification step is "Scan or Upload your NIMC Slip", which is
/// a file input. A customer reaching that step could complete their OTP and
/// their BVN/NIN check and then be unable to proceed, with the app giving them
/// no reason — reported verbatim as "I've tried to click these buttons here so
/// I can just upload my nin slip, but none of them are responding."
///
/// iOS needs none of this: WKWebView presents its own document/photo picker.
///
/// ## Why it offers the camera
///
/// The step asks the customer to SCAN a physical slip. Android's system
/// document picker does not include a camera source, so a files-only picker
/// would still leave somebody holding a paper slip with nowhere to point it.
/// An image-accepting input therefore gets the camera first.
class WebViewFileSelector {
  WebViewFileSelector._();

  /// Registers the handler on [controller]. Safe to call on any platform
  /// controller; only the Android one has this callback.
  static void attach(Object platformController) {
    if (platformController is! AndroidWebViewController) return;
    platformController.setOnShowFileSelector(pick);
  }

  /// Returns the chosen files as URIs the WebView can read.
  ///
  /// An empty list is the documented way to say "the user cancelled", and the
  /// page handles it as a dismissed picker. Every failure path returns empty
  /// rather than throwing: an exception here propagates into the WebView's
  /// native callback, and the cost of a crash on an identity screen is far
  /// worse than a picker that did not open.
  @visibleForTesting
  static Future<List<String>> pick(FileSelectorParams params) async {
    try {
      final wantsImage = acceptsImages(params.acceptTypes);
      final multiple = params.mode == FileSelectorMode.openMultiple;

      if (wantsImage && !multiple) {
        // Scanning a slip: the camera is the point of the step.
        final shot = await ImagePicker().pickImage(
          source: ImageSource.camera,
          // Mono re-encodes server-side; a smaller upload is a faster step on
          // Nigerian mobile data, which is where this flow actually runs.
          imageQuality: 85,
          maxWidth: 2000,
        );
        if (shot != null) return [Uri.file(shot.path).toString()];
        // Cancelled the camera — fall through to the file picker rather than
        // returning empty, so "I meant to upload one I already have" is one
        // dismissal away instead of a dead end.
      }

      final picked = await FilePicker.platform.pickFiles(
        type: wantsImage ? FileType.image : FileType.any,
        allowMultiple: multiple,
        withData: false,
      );
      if (picked == null) return const [];
      return picked.files
          .map((f) => f.path)
          .whereType<String>()
          .where((p) => File(p).existsSync())
          .map((p) => Uri.file(p).toString())
          .toList();
    } catch (e) {
      debugPrint('[WebViewFileSelector] picker failed: $e');
      return const [];
    }
  }

  /// Whether the page's accept list is asking for images.
  ///
  /// An EMPTY accept list means "anything", which is the common case for a
  /// bare `<input type="file">` — treated as not-image so the customer gets
  /// the full file picker rather than being pushed into a camera they may not
  /// want. A list naming image types, or the bare `image/*` wildcard, opts in.
  @visibleForTesting
  static bool acceptsImages(List<String> acceptTypes) {
    final types = acceptTypes
        .map((t) => t.trim().toLowerCase())
        .where((t) => t.isNotEmpty)
        .toList();
    if (types.isEmpty) return false;
    return types.every((t) =>
        t.startsWith('image/') ||
        t == '.jpg' ||
        t == '.jpeg' ||
        t == '.png' ||
        t == '.webp' ||
        t == '.heic');
  }
}
