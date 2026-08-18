import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import '../../domain/entities/bulk_sms_entities.dart';
import '../utils/bulk_sms_utils.dart';

/// Result of importing a CSV/TXT file of recipients.
class CsvImportResult {
  final List<SmsRecipientEntity> recipients;
  final int invalidCount;
  final int duplicateCount;
  final List<String> variableKeys;
  final bool cancelled;

  const CsvImportResult({
    this.recipients = const [],
    this.invalidCount = 0,
    this.duplicateCount = 0,
    this.variableKeys = const [],
    this.cancelled = false,
  });
}

/// Picks a `.csv`/`.txt` file and parses it into recipients. The FIRST column is
/// the phone number; every other named column becomes a `{{variable}}` on that
/// recipient. Numbers are normalized to NG E.164 and deduped.
class RecipientsCsvImporter {
  const RecipientsCsvImporter._();

  static Future<CsvImportResult> pickAndParse({
    Set<String> existingNumbers = const {},
  }) async {
    final picked = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv', 'txt'],
      withData: true,
    );
    if (picked == null || picked.files.isEmpty) {
      return const CsvImportResult(cancelled: true);
    }

    final file = picked.files.first;
    String content;
    final bytes = file.bytes;
    if (bytes != null) {
      content = utf8.decode(bytes, allowMalformed: true);
    } else {
      // On some platforms bytes may be null; without a path we can't read it.
      return const CsvImportResult(cancelled: true);
    }

    return parseContent(content, existingNumbers: existingNumbers);
  }

  /// Parse raw CSV/TXT [content]. Exposed separately so it's unit-testable.
  static CsvImportResult parseContent(
    String content, {
    Set<String> existingNumbers = const {},
  }) {
    final rows = const CsvToListConverter(
      eol: '\n',
      shouldParseNumbers: false,
    ).convert(content.replaceAll('\r\n', '\n').replaceAll('\r', '\n'));

    if (rows.isEmpty) {
      return const CsvImportResult();
    }

    // Detect a header row: if the first cell of row 0 isn't a valid number, we
    // treat row 0 as headers (phone,var1,var2,...).
    List<String> headers = [];
    var startIndex = 0;
    final firstCell = rows.first.isNotEmpty ? '${rows.first.first}'.trim() : '';
    final firstIsNumber = BulkSmsUtils.normalizeNg(firstCell) != null;
    if (!firstIsNumber && rows.first.isNotEmpty) {
      headers = rows.first.map((c) => '$c'.trim()).toList();
      startIndex = 1;
    }

    final seen = <String>{...existingNumbers};
    final out = <SmsRecipientEntity>[];
    final varKeys = <String>{};
    var invalid = 0;
    var duplicate = 0;

    for (var i = startIndex; i < rows.length; i++) {
      final row = rows[i];
      if (row.isEmpty) continue;
      final rawPhone = '${row.first}'.trim();
      if (rawPhone.isEmpty) continue;
      final norm = BulkSmsUtils.normalizeNg(rawPhone);
      if (norm == null) {
        invalid++;
        continue;
      }
      if (!seen.add(norm)) {
        duplicate++;
        continue;
      }

      String name = '';
      final variables = <String, String>{};
      for (var c = 1; c < row.length; c++) {
        final value = '${row[c]}'.trim();
        if (value.isEmpty) continue;
        final key = (c < headers.length && headers[c].isNotEmpty)
            ? _sanitizeKey(headers[c])
            : 'col$c';
        if (key == 'name') {
          name = value;
        }
        variables[key] = value;
        varKeys.add(key);
      }

      out.add(SmsRecipientEntity(
        phoneNumber: norm,
        name: name,
        variables: variables,
      ));
    }

    return CsvImportResult(
      recipients: out,
      invalidCount: invalid,
      duplicateCount: duplicate,
      variableKeys: varKeys.toList(),
    );
  }

  static String _sanitizeKey(String raw) {
    final cleaned = raw
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9_]'), '_')
        .replaceAll(RegExp(r'_+'), '_');
    return cleaned.isEmpty ? 'col' : cleaned;
  }
}
