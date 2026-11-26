import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/crowdfund/domain/entities/crowdfund_entities.dart';
import 'package:lazervault/src/features/crowdfund/presentation/utils/crowdfund_status_display.dart';

/// AN OPEN CAMPAIGN LOOKED EXACTLY LIKE A FINISHED ONE.
///
/// Reported as campaigns "which are not completed are currently showing
/// completed", on the crowdfund landing page and the view-all list. The
/// status VOCABULARY was already shared and already correct; the DRAWING of
/// it was not:
///
///   * `active` and `completed` were the same green (#10B981), differing
///     only by a 12sp icon;
///   * the landing page's "My campaigns" strip used that colour for an icon
///     and a progress bar and showed no label at all;
///   * the discover rows on the landing page carried no status of any kind.
///
/// So green-with-a-tick was the only signal, and it meant both things.
void main() {
  test('completed is the only state wearing the green', () {
    final greens = <String>[];
    for (final s in CrowdfundStatus.values) {
      final v = crowdfundStatusVisualFor(s);
      if (v.color == const Color(0xFF10B981)) greens.add(v.label);
    }
    expect(greens, ['Completed'],
        reason: 'active shared this exact green, which is why a live '
            'campaign read as a finished one');
  });

  test('completed is drawn loudly, and it is the only one that is', () {
    final loud = CrowdfundStatus.values
        .map(crowdfundStatusVisualFor)
        .where((v) => v.emphatic)
        .map((v) => v.label)
        .toList();
    expect(loud, ['Completed']);
    expect(
        crowdfundStatusVisualFor(CrowdfundStatus.completed).emoji, isNotEmpty);
  });

  test('a completed donation is marked the same way', () {
    final v = crowdfundDonationStatusVisual(DonationStatus.completed);
    expect(v.emphatic, isTrue);
    expect(v.emoji, isNotEmpty);
  });

  test('no surface keeps a private copy of either palette', () {
    // ANCHORED on the literal colours the duplicated switches used. Four
    // surfaces carried their own; a fifth would silently drift again.
    final offenders = <String>[];
    for (final f in Directory('lib/src/features/crowdfund')
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart'))) {
      if (f.path.endsWith('crowdfund_status_display.dart')) continue;
      final src = f.readAsStringSync();
      if (src.contains("label: 'Completed'")) {
        offenders.add(f.path);
      }
    }
    expect(offenders, isEmpty,
        reason: 'the campaign and donation palettes live in '
            'crowdfund_status_display.dart:\n${offenders.join('\n')}');
  });
}
