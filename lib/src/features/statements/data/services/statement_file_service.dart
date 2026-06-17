import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart' as crypto;
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

/// Pulls a generated statement from its signed `downloadUrl` to local disk and
/// exposes open/print/share actions over the saved file.
///
/// All bytes come from the backend-rendered file referenced by `downloadUrl`
/// (returned by accounts-service `GenerateStatement`). When a `sha256` is
/// supplied the downloaded bytes are verified against it before the file is
/// written, so we never hand the user a corrupted/truncated statement.
class StatementFileService {
  final Dio _dio;

  StatementFileService({Dio? dio}) : _dio = dio ?? Dio();

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

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file.path;
  }

  /// Open a saved file with the OS default handler.
  ///
  /// `open_filex` is not available in this app, so we open via a `file://` URI
  /// through url_launcher; if the platform can't handle it directly we fall
  /// back to the system share sheet so the user can still get to the file.
  Future<void> openFile(String path) async {
    final uri = Uri.file(path);
    if (await canLaunchUrl(uri)) {
      final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (launched) return;
    }
    await SharePlus.instance.share(ShareParams(files: [XFile(path)]));
  }

  /// Send a PDF at [path] to the system print dialog.
  Future<void> printPdf(String path) async {
    final bytes = await File(path).readAsBytes();
    await Printing.layoutPdf(onLayout: (_) async => bytes);
  }

  /// Share a saved file via the system share sheet.
  Future<void> shareFile(String path) async {
    await SharePlus.instance.share(ShareParams(files: [XFile(path)]));
  }
}
