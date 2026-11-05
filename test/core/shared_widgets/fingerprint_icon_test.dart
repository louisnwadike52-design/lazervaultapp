import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/shared_widgets/fingerprint_icon.dart';

/// A user reported the lock-screen biometric button as "that doesn't look like
/// fingerprint it looks like wifi icon". It did, and the reason was geometric
/// rather than a matter of taste.
///
/// Wi-Fi is nested arcs that get SHORTER inward, struck from one centre,
/// opening downward, with a mark at the bottom. A fingerprint's ridges wrap
/// FURTHER inward and are not concentric. The old painter had sweeps shrinking
/// 230°→158° from a single centre plus a straight tick at the core, which is
/// the Wi-Fi silhouette exactly.
///
/// These assert the properties that distinguish the two, so the glyph cannot
/// drift back into looking like a broadcast symbol.
void main() {
  group('fingerprint ridge geometry', () {
    test('ridges are ordered outermost first', () {
      for (var i = 1; i < kFingerprintRidges.length; i++) {
        expect(
          kFingerprintRidges[i][0],
          lessThan(kFingerprintRidges[i - 1][0]),
          reason: 'ridge $i must be tighter than the one outside it',
        );
      }
    });

    test('the bottom gap NARROWS inward — the anti-Wi-Fi property', () {
      for (var i = 1; i < kFingerprintRidges.length; i++) {
        expect(
          kFingerprintRidges[i][1],
          lessThan(kFingerprintRidges[i - 1][1]),
          reason: 'inner ridges must wrap FURTHER than outer ones. If the gap '
              'widens inward the inner arcs get shorter, which is precisely '
              'the Wi-Fi glyph the field reported.',
        );
      }
    });

    test('ridges are not concentric', () {
      final lifts = kFingerprintRidges.map((r) => r[2]).toSet();
      expect(
        lifts.length,
        kFingerprintRidges.length,
        reason: 'every ridge needs its own centre offset; identical centres '
            'read as a target/radar mark',
      );
      for (var i = 1; i < kFingerprintRidges.length; i++) {
        expect(
          kFingerprintRidges[i][2],
          greaterThan(kFingerprintRidges[i - 1][2]),
          reason: 'the centre should lift steadily as ridges tighten',
        );
      }
    });

    test('every gap leaves a real opening at the bottom, but never a fan', () {
      for (final r in kFingerprintRidges) {
        expect(r[1], greaterThan(0),
            reason: 'a fully closed ridge is an ellipse, not a fingerprint');
        expect(r[1], lessThan(90),
            reason: 'a gap at or past 90 degrees turns the ridge into a fan, '
                'which is the Wi-Fi shape again');
      }
    });
  });

  testWidgets('renders at lock-screen and tile sizes without error',
      (tester) async {
    for (final size in <double>[16, 22, 30, 48]) {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Center(child: FingerprintIcon(size: size, color: Colors.white)),
        ),
      ));
      expect(find.byType(FingerprintIcon), findsOneWidget);
      expect(tester.takeException(), isNull);
    }
  });
}
