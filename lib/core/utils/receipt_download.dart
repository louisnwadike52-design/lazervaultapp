import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

/// Where a downloaded receipt goes, and what the user can do with it.
///
/// On Android 11+ scoped storage an app cannot write into the shared Downloads
/// collection directly, so receipts are saved to the app's own external files
/// directory. That location is real and persistent, but it is NOT browsable in
/// the Files app — which made "Download Complete / Receipt saved" misleading:
/// the user went looking for a file they could not find.
///
/// Saving and then OPENING the file resolves that honestly. The receipt appears
/// immediately in a PDF viewer, from which the user can share or save it
/// wherever they want, and the copy no longer promises a folder that does not
/// contain it.
class ReceiptDownload {
  const ReceiptDownload._();

  /// Directory receipts are written to on this platform.
  static Future<Directory> targetDirectory() async {
    if (Platform.isAndroid) {
      // App-specific external files dir — always writable, no permission
      // needed. A direct write to /storage/emulated/0/Download fails under
      // Android scoped storage (API 30+), so never hardcode that path.
      return (await getExternalStorageDirectory()) ??
          await getApplicationDocumentsDirectory();
    }
    if (Platform.isIOS) {
      return getApplicationDocumentsDirectory();
    }
    return (await getDownloadsDirectory()) ??
        await getApplicationDocumentsDirectory();
  }

  /// Saves [source] into the receipts location as [fileName] and opens it.
  ///
  /// Returns the saved path. Opening is best-effort: a device with no PDF
  /// viewer still keeps the saved file, so the download itself never fails
  /// because the handoff did.
  static Future<String> saveAndOpen({
    required File source,
    required String fileName,
  }) async {
    final directory = await targetDirectory();
    final savedPath = '${directory.path}/$fileName';
    await source.copy(savedPath);

    try {
      final result = await OpenFilex.open(savedPath);
      if (result.type != ResultType.done) {
        debugPrint('[ReceiptDownload] viewer declined to open: ${result.message}');
      }
    } catch (e) {
      debugPrint('[ReceiptDownload] could not open the saved receipt: $e');
    }
    return savedPath;
  }

  /// Message to show after a successful download.
  ///
  /// Deliberately does not name a folder: on Android the file is not where a
  /// user would go looking, so the honest promise is that it is saved and
  /// opening, not that it is "in Downloads".
  static const String successTitle = 'Receipt saved';
  static const String successBody = 'Opening your receipt — share or save it from there.';
}
