import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/services/chat_theme_preference.dart';

/// THE THREE-DOT MENU HAD NOTHING ABOUT HOW THE ASSISTANT LOOKS.
///
/// Clear Chat, Export Chat, AI Settings — all about what it SAYS, on a screen
/// people keep open for a long time. Reported twice.
void main() {
  String code(String path) => File(path).readAsLinesSync().where((l) {
        final t = l.trimLeft();
        return !t.startsWith('//') && !t.startsWith('///') && !t.startsWith('*');
      }).join('\n');

  group('the accents themselves', () {
    test('every accent has a stable id, a label and two colours', () {
      expect(ChatThemePreference.accents, isNotEmpty);
      for (final a in ChatThemePreference.accents) {
        expect(a.id, isNotEmpty);
        expect(a.label, isNotEmpty);
        expect(a.primary, isA<Color>());
        expect(a.secondary, isA<Color>());
      }
    });

    test('ids are unique, because they are what gets stored', () {
      final ids = ChatThemePreference.accents.map((a) => a.id).toList();
      expect(ids.toSet().length, ids.length);
    });

    test('an unknown id falls back instead of painting nothing', () {
      // A deployment can set a default ahead of a store release, so this
      // build may be asked for an accent it does not have.
      expect(ChatThemePreference.byId('chartreuse').id,
          ChatThemePreference.accents.first.id);
      expect(ChatThemePreference.byId(null).id,
          ChatThemePreference.accents.first.id);
    });

    test('bubble radius follows the shape switch', () {
      // Without SharedPreferences initialised the getter takes its default,
      // which is rounded — the shape the chat has always had.
      expect(ChatThemePreference.bubbleRadius, 18);
    });
  });

  group('the sheet', () {
    final sheet = code(
      'lib/src/features/ai_chats/presentation/widgets/chat_theme_sheet.dart',
    );

    test('applies a choice immediately, with a live preview', () {
      expect(sheet, contains('ChatThemePreference.setAccent'));
      expect(sheet, contains('ChatThemePreference.setRoundedBubbles'));
      // No Save button: the preview is the confirmation.
      expect(sheet, isNot(contains("Text('Save'")));
    });

    test('offers a way back to the platform default', () {
      expect(sheet, contains('ChatThemePreference.clearAccent'));
      expect(sheet, contains('Use the default'));
    });
  });

  group('the chat uses it', () {
    final chat = code(
      'lib/src/features/ai_chats/presentation/widgets/ai_chat_content.dart',
    );

    test('the menu offers Chat theme', () {
      expect(chat, contains("'Chat theme'"));
      expect(chat, contains('ChatThemeSheet.show(context)'));
    });

    test('bubbles and header read the accent, not a fixed purple', () {
      expect(chat, contains('ChatThemePreference.accent.primary'));
      expect(chat, contains('_accent.primary'));
      expect(chat, contains('ChatThemePreference.bubbleRadius'));
    });

    test('the bubble colour is NOT a static final', () {
      // A static final is computed once per process, so the bubbles would
      // keep whichever accent happened to be in force the first time this
      // class was touched and ignore every later change.
      expect(chat, isNot(contains('static final _userBubbleColor')));
      expect(chat, contains('Color get _userBubbleColor'));
    });

    test('an open chat repaints when the theme changes', () {
      expect(chat, contains('valueListenable: ChatThemePreference.revision'));
    });
  });

  group('the platform default reaches the app', () {
    test('the key is declared and read as a string', () {
      final flags = code('lib/core/config/feature_flags.dart');
      expect(flags, contains("chatDefaultAccentKey = 'chat_default_accent'"));
      expect(flags, contains('static String get chatDefaultAccent'));
    });

    test('it survives the settings snapshot the app polls', () {
      expect(code('lib/core/services/endpoint_registry.dart'),
          contains("'chat_default_accent'"));
    });

    test('the admin gateway accepts and returns it', () {
      expect(
        File('../services/admin-gateway/internal/handlers/voice_agents_admin.go')
            .readAsStringSync(),
        contains('"chat_default_accent": true'),
      );
      expect(
        File('../services/admin-gateway/internal/handlers/voice_agents_admin_part1.go')
            .readAsStringSync(),
        contains('"chat_default_accent"'),
      );
    });

    test('it is NOT coerced to a bool, because it is a name', () {
      expect(
        File('../services/admin-gateway/internal/handlers/voice_agents_admin_part3.go')
            .readAsStringSync(),
        isNot(contains('chat_default_accent')),
        reason: 'coercing it would turn an accent name into "false"',
      );
    });

    test('the dashboard offers it as a named choice', () {
      final tab = File(
        '../apps/admin-dashboard/src/app/settings/page/'
        'AssistantEntryPointsTab.tsx',
      ).readAsStringSync();
      expect(tab, contains('chat_default_accent'));
      expect(tab, contains('App default'));
    });
  });
}
