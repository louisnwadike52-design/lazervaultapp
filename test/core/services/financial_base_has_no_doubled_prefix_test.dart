import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';

// THE BUG THIS EXISTS TO STOP COMING BACK
// ---------------------------------------
// financial-gateway serves two differently-shaped route families. Most are
// annotated `/api/v1/...`. But the group-accounts and exchange protos annotate
// theirs as a BARE `/v1/...`:
//
//   /v1/group-join-links/{token}      /v1/exchange/payout-banks
//   /v1/groups/{id}/join-link         /v1/exchange/transfer-requirements
//   /v1/group-funds/fee-quote         /v1/exchange/report-issue
//   /v1/contributions/{id}/messages   /v1/me/past-groups
//
// `endpointRegistry.httpFinancial` already ends in `/api/v1`, so appending one
// of those produces `/api/v1/v1/...`. That matches the edge's
// `^/api/v1(/.*)?$` catch-all, lands on core-gateway — which has no such route
// — and answers `{"code":5,"message":"Not Found"}`. The caller sees a 404 from
// a route that exists and is healthy, which is the hardest possible shape to
// diagnose from the app side.
//
// It has already been found and fixed twice, each time by copying a private
// `_stripApiV1` into one more data source (contribution chat, then past
// memberships) while three other call sites still had the defect. A per-file
// copy cannot fix the next one. So the strip lives on EndpointRegistry, and
// this test fails if any file goes back to appending `/v1/` to the suffixed
// base.

/// Repository root, found by walking up from the test's working directory.
Directory _libDir() {
  var dir = Directory.current;
  for (var i = 0; i < 6; i++) {
    final lib = Directory('${dir.path}/lib');
    if (lib.existsSync()) return lib;
    dir = dir.parent;
  }
  fail('could not locate lib/ from ${Directory.current.path}');
}

void main() {
  group('stripApiV1Suffix', () {
    test('removes exactly one trailing /api/v1', () {
      expect(
        EndpointRegistry.stripApiV1Suffix('https://api.lazervault.app/api/v1'),
        'https://api.lazervault.app',
      );
    });

    test('tolerates trailing slashes', () {
      for (final input in [
        'https://api.lazervault.app/api/v1/',
        'https://api.lazervault.app/api/v1//',
      ]) {
        expect(EndpointRegistry.stripApiV1Suffix(input),
            'https://api.lazervault.app');
      }
    });

    test('leaves a base that does not carry the suffix alone', () {
      expect(
        EndpointRegistry.stripApiV1Suffix('https://api.lazervault.app'),
        'https://api.lazervault.app',
      );
      expect(
        EndpointRegistry.stripApiV1Suffix('http://10.0.2.2:8016'),
        'http://10.0.2.2:8016',
      );
    });

    test('only strips at the END, never mid-path', () {
      expect(
        EndpointRegistry.stripApiV1Suffix('https://h/api/v1/exchange'),
        'https://h/api/v1/exchange',
        reason: 'a base that already points INTO /api/v1 is not the same shape',
      );
    });

    test('does not strip a lookalike', () {
      for (final input in [
        'https://h/api/v10',
        'https://h/api/v1x',
        'https://h/xapi/v1',
      ]) {
        expect(EndpointRegistry.stripApiV1Suffix(input), input);
      }
    });

    test('is idempotent', () {
      const once = 'https://api.lazervault.app';
      expect(
        EndpointRegistry.stripApiV1Suffix(
            EndpointRegistry.stripApiV1Suffix('$once/api/v1')),
        once,
      );
    });
  });

  test('no file appends a bare /v1/ path to the /api/v1-suffixed base',
      () async {
    final offenders = <String>[];

    await for (final entity in _libDir().list(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) continue;
      if (entity.path.contains('/generated/')) continue;
      // The registry DEFINES both getters and builds unrelated `/v1/...` URLs
      // of its own (`${_tierBase('https')}/v1/storage`). It is the definition
      // site, not a consumer.
      if (entity.path.endsWith('core/services/endpoint_registry.dart')) {
        continue;
      }
      final code = _stripComments(entity.readAsStringSync());

      // Appending a bare `/v1/...` to an interpolated base: `$baseUrl/v1/x`,
      // `$_base/v1/x`, `${endpointRegistry.httpFinancial}/v1/x`.
      if (!RegExp(r'\$\{?[A-Za-z_][A-Za-z0-9_.]*\}?/v1/').hasMatch(code)) {
        continue;
      }
      // ...while taking the base from the SUFFIXED getter. `(?!Root)` is the
      // whole point: `httpFinancialRoot` is the correct one and must not match.
      if (RegExp(r'\bhttpFinancial\b(?!Root)').hasMatch(code)) {
        offenders.add(entity.path.split('/lib/').last);
      }
    }

    expect(
      offenders,
      isEmpty,
      reason: 'these append a bare /v1/ path to endpointRegistry.httpFinancial, '
          'which already ends in /api/v1 — the request goes out as '
          '/api/v1/v1/... and 404s from core-gateway. Use '
          'endpointRegistry.httpFinancialRoot (or '
          'EndpointRegistry.stripApiV1Suffix on a dotenv override) instead:\n'
          '  ${offenders.join('\n  ')}',
    );
  });

  test('the scan itself detects the defect', () {
    // Without this, the scan above could pass because it is looking in the
    // wrong place and nobody would know. The first version of it DID: it
    // checked `text.contains('httpFinancialRoot')` over the whole file, so a
    // doc comment that merely MENTIONED the correct getter was enough to make a
    // genuinely broken file look clean. Comments are stripped now, and this
    // asserts the predicate on known-bad and known-good code.
    bool flags(String src) {
      final code = _stripComments(src);
      return RegExp(r'\$\{?[A-Za-z_][A-Za-z0-9_.]*\}?/v1/').hasMatch(code) &&
          RegExp(r'\bhttpFinancial\b(?!Root)').hasMatch(code);
    }

    expect(
      flags('''
        final base = endpointRegistry.httpFinancial;
        final uri = Uri.parse('\$base/v1/group-join-links/\$token');
      '''),
      isTrue,
      reason: 'this is exactly the shape that 404d',
    );

    expect(
      flags('''
        /// Uses endpointRegistry.httpFinancialRoot, see stripApiV1Suffix.
        final base = endpointRegistry.httpFinancial;
        final uri = Uri.parse('\$base/v1/group-join-links/\$token');
      '''),
      isTrue,
      reason: 'a doc comment naming the right getter must not excuse the code',
    );

    expect(
      flags('''
        final base = endpointRegistry.httpFinancialRoot;
        final uri = Uri.parse('\$base/v1/group-join-links/\$token');
      '''),
      isFalse,
      reason: 'the stripped base is the fix, not a violation',
    );

    expect(
      flags('''
        final base = endpointRegistry.httpFinancial;
        final uri = Uri.parse('\$base/exchange/quote');
      '''),
      isFalse,
      reason: 'an /api/v1-shaped route on the suffixed base is correct',
    );
  });
}

/// Dart source with `//` and `/* */` comments removed.
///
/// String literals are left alone — a `//` inside one is vanishingly rare in
/// this codebase's URL building and erring toward scanning MORE text only risks
/// a false positive, which is loud and easy to fix, never a silent miss.
String _stripComments(String src) => src
    .replaceAll(RegExp(r'/\*.*?\*/', dotAll: true), '')
    .replaceAll(RegExp(r'^\s*///?.*$', multiLine: true), '');
