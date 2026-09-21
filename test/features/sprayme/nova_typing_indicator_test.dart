import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/sprayme/presentation/widgets/nova_typing_indicator.dart';

void main() {
  group('Nova thinking stages', () {
    test('advances reading -> thinking -> typing as the wait grows', () {
      expect(novaStageFor(Duration.zero), NovaThinkingStage.reading);
      expect(novaStageFor(const Duration(milliseconds: 900)),
          NovaThinkingStage.reading);
      expect(novaStageFor(const Duration(milliseconds: 1200)),
          NovaThinkingStage.thinking);
      expect(novaStageFor(const Duration(seconds: 3)),
          NovaThinkingStage.thinking);
      expect(novaStageFor(const Duration(seconds: 4)),
          NovaThinkingStage.typing);
      // A long agent turn stays on the last stage rather than resetting.
      expect(novaStageFor(const Duration(minutes: 2)),
          NovaThinkingStage.typing);
    });

    test('never goes backwards as elapsed time increases', () {
      var previous = -1;
      for (var ms = 0; ms < 8000; ms += 50) {
        final index = novaStageFor(Duration(milliseconds: ms)).index;
        expect(index, greaterThanOrEqualTo(previous));
        previous = index;
      }
    });

    test('labels name the assistant, not the old product names', () {
      for (final stage in NovaThinkingStage.values) {
        expect(stage.label, startsWith('Nova is '));
        expect(stage.label.toLowerCase(), isNot(contains('lazerai')));
        expect(stage.label.toLowerCase(), isNot(contains('lazerray')));
      }
      expect(NovaThinkingStage.reading.label, 'Nova is reading');
      expect(NovaThinkingStage.thinking.label, 'Nova is thinking');
      expect(NovaThinkingStage.typing.label, 'Nova is typing');
    });
  });
}
