import 'dart:io';

import 'package:crypto/crypto.dart' as crypto;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:open_filex/open_filex.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:ui' show Rect;

import '../../../../../core/utils/receipt_download.dart';

/// Raised when we could not open the file but DID put it somewhere useful.
///
/// Distinct from a plain Exception so the caller can show it as information
/// rather than as a failure — the statement is downloaded and the share sheet
/// is open; nothing went wrong that the user needs to retry.
class StatementOpenFallback implements Exception {
  final String message;
  const StatementOpenFallback(this.message);
  @override
  String toString() => message;
}

/// Pulls a generated statement from its signed `downloadUrl` to local disk and
/// exposes open/print/share actions over the saved file.
///
/// All bytes come from the backend-rendered file referenced by `downloadUrl`
/// (returned by accounts-service `GenerateStatement`). When a `sha256` is
/// supplied the downloaded bytes are verified against it before the file is
/// written, so we never hand the user a corrupted/truncated statement.
class StatementFileService {
  final Dio _dio;

  StatementFileService({Dio? dio}) : _dio = dio ?? _defaultClient();

  /// A plain Dio WITH TIMEOUTS.
  ///
  /// This was `Dio()`, whose connect/receive timeouts both default to null —
  /// meaning no limit at all. A download that stalled (a dropped connection
  /// mid-body, a captive portal, a cold object store) therefore never
  /// returned and never threw: the screen sat on `_isPreparingFile = true`
  /// for ever, with no error and no way back except leaving the screen. From
  /// the user's side that is indistinguishable from the feature being broken,
  /// and it is reported as "download doesn't work".
  ///
  /// A statement is a small file fetched over the same tunnel as every other
  /// call, so these are generous: they exist to turn a hang into a message,
  /// not to police a slow connection. The caller already surfaces any throw
  /// as a snackbar, so a timeout now tells the user what happened and leaves
  /// the Retry affordance usable.
  static Dio _defaultClient() => Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 20),
          receiveTimeout: const Duration(seconds: 60),
          sendTimeout: const Duration(seconds: 30),
        ),
      );

  /// Download [url] to a file named [filename] under the platform's documents
  /// directory and return the absolute local path.
  ///
  /// When [expectedSha256] is non-null the SHA-256 of the downloaded bytes must
  /// match it (case-insensitive) or an [Exception] is thrown.
  Future<String> downloadToFile(
    String url,
    String filename, {
    String? expectedSha256,
  }) async {
    if (url.isEmpty) {
      throw Exception('No download URL was provided for this statement.');
    }

    final response = await _dio.get<List<int>>(
      url,
      options: Options(responseType: ResponseType.bytes),
    );

    final data = response.data;
    if (data == null || data.isEmpty) {
      throw Exception('The downloaded statement was empty.');
    }
    final bytes = Uint8List.fromList(data);

    if (expectedSha256 != null && expectedSha256.isNotEmpty) {
      final actual = crypto.sha256.convert(bytes).toString();
      if (actual.toLowerCase() != expectedSha256.toLowerCase()) {
        throw Exception(
          'Downloaded statement failed integrity check. Please try again.',
        );
      }
    }

    // Same location receipts use. On Android `getApplicationDocumentsDirectory`
    // returns the app's PRIVATE `app_flutter` dir; a file there cannot be
    // handed to a PDF viewer, which is half the reason Open never worked.
    // `ReceiptDownload.targetDirectory()` resolves to the app's external files
    // dir on Android (no permission needed, covered by the FileProvider paths)
    // and Documents on iOS.
    final dir = await ReceiptDownload.targetDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file.path;
  }

  /// Open a saved file with the OS default handler.
  ///
  /// THIS USED TO BE A SHARE SHEET WEARING AN "OPEN" LABEL.
  ///
  /// It built `Uri.file(path)` and went through url_launcher, on the stated
  /// grounds that "open_filex is not available in this app". open_filex IS a
  /// dependency (pubspec 4.5.0) and `ReceiptDownload` has been opening every
  /// receipt with it in production for months — the comment was simply wrong,
  /// and the code written around it could not work:
  ///
  ///  * Android has refused to pass a `file://` URI across an app boundary
  ///    since API 24 (FileUriExposedException), and the file lives in our own
  ///    private container, which no viewer is allowed to read anyway. So
  ///    `canLaunchUrl` fails, or the launch does.
  ///  * iOS has no handler registered for the `file` scheme either.
  ///
  /// Both paths therefore fell through to the share sheet. Tapping "Open" in
  /// the "Statement downloaded" sheet produced a SHARE dialog — the user asked
  /// to read their statement and was asked who to send it to. That is the
  /// reported "'open' option doesn't work".
  ///
  /// `OpenFilex` hands the file to a viewer through a FileProvider
  /// `content://` URI on Android and `UIDocumentInteractionController` on iOS,
  /// which is the supported way to do this and the way receipts already do it.
  /// Share stays available as its own action in the sheet, and as the fallback
  /// here only when the device genuinely has no viewer for the type — which is
  /// a real condition on a CSV, and worth telling the user about rather than
  /// silently substituting.
  Future<void> openFile(String path) async {
    final result = await OpenFilex.open(path);
    if (result.type == ResultType.done) return;

    debugPrint('[StatementFileService] viewer declined to open: '
        '${result.type} ${result.message}');

    if (result.type == ResultType.noAppToOpen) {
      // A CSV on a phone with no spreadsheet app is the common case. Share is
      // a genuinely useful answer here, so offer it rather than erroring —
      // but the user asked to open, so say why they are seeing this.
      await shareFile(path);
      throw StatementOpenFallback(
        'No app on this device can open that file, so we opened the share '
        'sheet instead — send it to an app that can.',
      );
    }

    throw Exception(
      'Your statement is saved but could not be opened: ${result.message}',
    );
  }

  /// Send a PDF at [path] to the system print dialog.
  Future<void> printPdf(String path) async {
    final bytes = await File(path).readAsBytes();
    await Printing.layoutPdf(onLayout: (_) async => bytes);
  }

  /// Share a saved file via the system share sheet.
  Future<void> shareFile(String path) async {
    await SharePlus.instance.share(ShareParams(
        // iOS: a non-zero popover anchor is required — CGRectZero throws
        // PlatformException and the share silently fails on iPhone/iPad.
        sharePositionOrigin: const Rect.fromLTWH(0, 0, 1, 1),
        files: [XFile(path)]));
  }
}
