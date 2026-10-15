import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Lazerfunds draws no decorative hairlines.
///
/// `kUpDivider` is #2D2D2D. A `kUpCard` fill is #1F1F1F and the page is
/// #0A0A0A — so the fill ALREADY separates a row from the page by 21 points of
/// luminance, and a kUpDivider outline adds a 14-point box around it. One such
/// box looks like a choice; a list of them looks like a rendering fault, which
/// is what the listing rows actually looked like.
///
/// The rule this pins: **a container that has a fill does not also get an
/// outline.** A border survives only where it is the sole carrier of something:
///
///   * an OutlinedButton's `side` — the edge IS the button
///   * `Border(top: ...)` — a rule BETWEEN rows, not a box around one
///   * a state the fill does not show (a file is attached; a section is on)
///
/// Written as a source scan because this is a styling rule across many files
/// and no widget test would notice it coming back in the eleventh.
void main() {
  final dir = Directory('lib/src/features/uplift/presentation');

  List<String> dartFiles() => dir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .map((f) => f.path)
      .toList()
    ..sort();

  /// Comment lines are stripped: these files now EXPLAIN the rule and quote
  /// `Border.all(color: kUpDivider)` while doing so, and a raw scan would match
  /// the explanation and fail on correct code.
  String codeOf(String p) => File(p)
      .readAsStringSync()
      .split('\n')
      .where((l) => !l.trimLeft().startsWith('//'))
      .join('\n');

  test('the feature is where this test thinks it is', () {
    expect(dir.existsSync(), isTrue, reason: 'uplift presentation moved');
    expect(dartFiles(), isNotEmpty);
  });

  test('no container is outlined in the divider colour', () {
    final offenders = <String>[];
    for (final p in dartFiles()) {
      final code = codeOf(p);
      // Border.all — a box. BorderSide inside a Border(top:/bottom:) is a rule
      // between rows and is allowed, as is an OutlinedButton's own side.
      final re = RegExp(r'Border\.all\(\s*color:\s*kUpDivider');
      for (final m in re.allMatches(code)) {
        final line = code.substring(0, m.start).split('\n').length;
        offenders.add('$p:$line');
      }
    }
    expect(offenders, isEmpty,
        reason: 'a kUpDivider box around a filled card is the hairline this '
            'rule removed — use the fill, or a Border(top:) rule if rows need '
            'separating. Offenders: ${offenders.join(', ')}');
  });

  test('the listing rows are not outlined at all', () {
    // The two cards a user scrolls past: a fund in Discover/My Funds, and an
    // application in My Applications. Both had a box; neither may have one.
    final code = codeOf(
        'lib/src/features/uplift/presentation/widgets/uplift_widgets.dart');
    for (final card in ['class UpliftFundCard', 'class UpliftApplicationCard']) {
      final i = code.indexOf(card);
      expect(i, greaterThan(-1), reason: '$card moved; re-point this guard');
      // The decoration sits within the first stretch of the build method.
      final window = code.substring(i, (i + 2200).clamp(0, code.length));
      expect(window, contains('color: kUpCard'),
          reason: '$card lost its fill, which is what replaced the border');
      expect(window, isNot(contains('border: Border.all')),
          reason: '$card drew a box around itself again');
    }
  });

  test('a state-carrying border is still allowed', () {
    // The guard above must not have been satisfied by deleting the one border
    // that means something — the purple edge that says a file is attached.
    final code = codeOf(
        'lib/src/features/uplift/presentation/widgets/uplift_widgets.dart');
    expect(code, contains('has ? Border.all(color: kUpPrimary) : null'),
        reason: 'the attached-file state has no other indicator on that row');
  });

  test('the comment strip actually strips (self-check)', () {
    const sample = '// border: Border.all(color: kUpDivider),\n  final x = 1;\n';
    final stripped = sample
        .split('\n')
        .where((l) => !l.trimLeft().startsWith('//'))
        .join('\n');
    expect(stripped, isNot(contains('kUpDivider')));
    expect(stripped, contains('final x = 1;'));
  });
}
