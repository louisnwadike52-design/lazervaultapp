import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// The brand is **Lazervault**, one capital.
///
/// "LazerVault" (a capital V mid-word) and "LAZERVAULT" had spread through
/// receipts, PDFs, chat-agent replies, voice-agent prompts and the transfer
/// narration a recipient's own bank shows them. Identifiers are a different
/// matter — `LazerVaultLoader` is a class name and renaming 1,400 symbols to
/// fix a word nobody reads would be a worse trade — so this scans only the
/// places the user actually sees.
void main() {
  /// Lines that reach a person: a quoted string, excluding comments.
  ///
  /// Deliberately crude. The alternative is a Dart parser, and the failure
  /// mode of crude here is a false POSITIVE on a line the author can fix or
  /// exempt in one move — not a miss.
  List<String> offendingLines(File f) {
    final out = <String>[];
    final lines = f.readAsLinesSync();
    for (var i = 0; i < lines.length; i++) {
      final line = lines[i];
      final trimmed = line.trimLeft();
      if (trimmed.startsWith('//') || trimmed.startsWith('*')) continue;
      final match = RegExp('LazerVault|LAZERVAULT').firstMatch(line);
      if (match == null) continue;
      // Identifier, not copy: glued to a word character on either side.
      final before = match.start > 0 ? line[match.start - 1] : ' ';
      final after =
          match.end < line.length ? line[match.end] : ' ';
      final wordChar = RegExp(r'[A-Za-z0-9_]');
      if (wordChar.hasMatch(before) || wordChar.hasMatch(after)) continue;
      // Inside a quote on this line?
      final head = line.substring(0, match.start);
      final quoted = head.split("'").length.isEven ||
          head.split('"').length.isEven;
      if (!quoted) continue;
      // A storage path, not copy. The receipts folder is NOT renamed: new
      // receipts would land in a second directory and a user's previously
      // saved ones would stay behind in the first, which is worse than one
      // inconsistently-cased folder name.
      if (line.contains('Directory(')) continue;
      // A case-insensitive comparison against a bank's own spelling.
      if (line.contains('toUpperCase().contains') ||
          line.contains('toLowerCase().contains')) continue;
      out.add('${f.path}:${i + 1}: ${trimmed.trim()}');
    }
    return out;
  }

  test('no user-facing copy in lib/ spells the brand with a mid-word capital',
      () {
    final lib = Directory('lib');
    expect(lib.existsSync(), isTrue, reason: 'run this from the app root');
    final offenders = <String>[];
    for (final e in lib.listSync(recursive: true)) {
      if (e is! File || !e.path.endsWith('.dart')) continue;
      // Generated protobuf carries the .proto file's own contact metadata.
      if (e.path.contains('/generated/') || e.path.contains('.pb')) continue;
      offenders.addAll(offendingLines(e));
    }
    expect(offenders, isEmpty,
        reason: 'the brand is "Lazervault":\n${offenders.join('\n')}');
  });
}
