import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// pubspec declares the whole `assets/` directory as an asset bundle, so ANY
/// file dropped in there ships inside the IPA and the AAB where anyone can
/// extract it. A stale `assets/.env` carrying a LiveKit API key and secret for
/// a real LiveKit Cloud project rode along in every build up to 1.0.1+452 that
/// way — gitignored, so it never showed up in a diff or a commit scan, and
/// never read by the app (it loads the root `.env`), so nothing failed.
///
/// These are source guards, not behavioural tests: the failure mode is a file
/// EXISTING, which no amount of exercising the app will surface.
void main() {
  group('bundled assets carry no credentials', () {
    test('assets/.env does not exist', () {
      final f = File('assets/.env');
      expect(
        f.existsSync(),
        isFalse,
        reason: 'assets/.env is bundled by the blanket `- assets/` entry in '
            'pubspec.yaml and would ship extractable inside the app. The app '
            'reads the ROOT .env (declared as `- .env`), so this file is never '
            'loaded — it is pure exposure. Keep environment files out of '
            'assets/.',
      );
    });

    test('no file under assets/ contains a secret-shaped assignment', () {
      // Deliberately literal: these are the shapes that actually appeared.
      final patterns = <RegExp>[
        RegExp(
            r'^[A-Z0-9_]*(SECRET|PRIVATE_KEY|API_KEY|TOKEN|PASSWORD)[A-Z0-9_]*\s*=\s*\S{12,}',
            multiLine: true),
        RegExp(r'-----BEGIN [A-Z ]*PRIVATE KEY-----'),
      ];

      final dir = Directory('assets');
      if (!dir.existsSync()) return;

      final offenders = <String>[];
      for (final entity in dir.listSync(recursive: true)) {
        if (entity is! File) continue;
        // Only text-ish files can be scanned meaningfully; skip binaries.
        const binary = {
          '.png',
          '.jpg',
          '.jpeg',
          '.gif',
          '.webp',
          '.svg',
          '.ttf',
          '.otf',
          '.woff',
          '.woff2',
          '.mp3',
          '.mp4',
          '.wav',
          '.riv',
          '.lottie',
          '.zip',
        };
        final lower = entity.path.toLowerCase();
        if (binary.any(lower.endsWith)) continue;

        String content;
        try {
          content = entity.readAsStringSync();
        } on FileSystemException {
          continue; // unreadable or not UTF-8 — not a credential file we can read
        }
        if (patterns.any((p) => p.hasMatch(content))) {
          offenders.add(entity.path);
        }
      }

      expect(
        offenders,
        isEmpty,
        reason:
            'These bundled asset files contain credential-shaped values and '
            'would ship extractable inside the app: ${offenders.join(', ')}. '
            'Move them out of assets/.',
      );
    });
  });
}
