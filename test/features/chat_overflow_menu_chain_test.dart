// The central chatbot's 3-dot menu: Clear chat, Export chat, AI settings.
//
// All three were already built. What nothing guarded is the CHAIN behind "AI
// settings", which crosses Dart and Python in five links:
//
//   modal writes SharedPreferences  (AiChatSettings.save)
//     -> the HTTP datasource re-reads those keys AT SEND TIME, by raw string
//     -> metadata.response_style / metadata.emoji_usage on the wire
//     -> chat-agent-gateway builds `response_style_instruction`
//     -> every chat-*-service agent appends it to its system prompt
//
// Link 2 is the fragile one: the datasource retypes the preference keys as
// string literals rather than reusing the model's `_prefix`, so a one-character
// difference leaves the toggle flipping a value nobody reads — a control that
// changes nothing, which is indistinguishable from a model that ignores it.
//
// Asserted across the real files because that is the only place this chain
// exists; there is no single component to unit-test.

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

String _app(String p) => File(p).readAsStringSync();
String _repo(String p) {
  final f = File('../$p');
  expect(f.existsSync(), isTrue, reason: 'cannot find $p — path moved?');
  return f.readAsStringSync();
}

const _model =
    'lib/src/features/ai_chats/presentation/widgets/ai_chat_content_widgets.dart';
const _content =
    'lib/src/features/ai_chats/presentation/widgets/ai_chat_content.dart';
const _datasource =
    'lib/src/features/ai_chats/data/datasources/http_ai_chat_datasource.dart';

void main() {
  group('the 3-dot menu offers all three actions, each wired to real work', () {
    final src = _app(_content);

    test('Clear Chat, Export Chat and AI Settings are all present', () {
      for (final label in ['Clear Chat', 'Export Chat', 'AI Settings']) {
        expect(src.contains("'$label'"), isTrue,
            reason: 'the menu lost its "$label" entry');
      }
    });

    test('each entry calls its handler, not a placeholder', () {
      for (final fn in [
        '_showClearChatConfirmation()',
        '_showExportFormatSheet()',
        '_showAiSettingsModal()',
      ]) {
        expect(src.contains(fn), isTrue, reason: '$fn is no longer invoked');
        // and the handler must exist
        final name = fn.replaceAll('()', '');
        expect(RegExp('(void|Future<[^>]*>)\\s*$name\\s*\\(').hasMatch(src),
            isTrue,
            reason: '$name is called but not defined');
      }
    });

    test('Clear only reports success when the SERVER cleared', () {
      // A local-only clear that says "Chat cleared" is a lie the next history
      // load exposes.
      expect(RegExp(r'await context\.read<AIChatCubit>\(\)\.clearChat\(\)')
              .hasMatch(src),
          isTrue,
          reason: 'clear no longer goes through the cubit, so it cannot be '
              'server-backed');
      expect(
        RegExp(r'final ok = await context\.read<AIChatCubit>\(\)\.clearChat\(\)')
            .hasMatch(src),
        isTrue,
        reason: 'the result of clearChat is discarded — a failed clear would '
            'still be reported as done',
      );
    });

    test('Export covers the four offered formats and shares a FILE', () {
      // A format has to be BOTH offered in the sheet and handled in the
      // switch. Checking the enum name file-wide passes when the menu tile is
      // deleted but the dead switch arm remains.
      for (final f in ['pdf', 'csv', 'whatsapp', 'text']) {
        expect(
          RegExp('tile\\([^;]*?ChatExportFormat\\.$f\\)', dotAll: true)
              .hasMatch(src),
          isTrue,
          reason: '$f is no longer OFFERED in the export sheet',
        );
        expect(src.contains('case ChatExportFormat.$f:'), isTrue,
            reason: '$f is offered but no longer HANDLED');
      }
      expect(src.contains('files: [XFile(file.path)]'), isTrue,
          reason: 'the export no longer shares a file');
      // iOS throws on a zero-size popover anchor and the share silently
      // fails. Scoped to the EXPORT share: this file makes other share calls,
      // so a file-wide check for the anchor passes while export has none.
      expect(
        RegExp(
          r'SharePlus\.instance\.share\(ShareParams\('
          r'(?:(?!\)\);).)*?sharePositionOrigin'
          r'(?:(?!\)\);).)*?files: \[XFile\(file\.path\)\]',
          dotAll: true,
        ).hasMatch(src),
        isTrue,
        reason: "the export's own share call has no sharePositionOrigin — it "
            'fails silently on iPhone/iPad',
      );
      // The PDF must embed a font or the naira sign and any non-Latin text
      // render as blanks.
      expect(src.contains('ReceiptFonts.document()'), isTrue,
          reason: 'the transcript PDF no longer embeds a font');
      // Export the whole transcript, not the scrolled window.
      expect(src.contains('fetchAllForExport'), isTrue,
          reason: 'export no longer pulls the full server history');
    });
  });

  group('the AI-settings chain reaches the agent', () {
    final model = _app(_model);
    final datasource = _app(_datasource);

    test('every key the model persists uses the one prefix', () {
      final written = RegExp(r"\$\{_prefix\}([a-z_]+)")
          .allMatches(model)
          .map((m) => 'ai_chat_settings_${m.group(1)}')
          .toSet();
      expect(written.length, 5,
          reason: 'expected 5 persisted settings, found ${written.length}');
      expect(
        written,
        {
          'ai_chat_settings_response_style',
          'ai_chat_settings_text_size',
          'ai_chat_settings_show_timestamps',
          'ai_chat_settings_emoji_usage',
          'ai_chat_settings_quick_suggestions',
        },
      );
    });

    test('the keys the datasource re-reads exist in the model', () {
      // THE FRAGILE LINK. These are string literals duplicated from the
      // model; a mismatch is silent.
      final read = RegExp(r"'(ai_chat_settings_[a-z_]+)'")
          .allMatches(datasource)
          .map((m) => m.group(1)!)
          .toSet();
      expect(read, isNotEmpty,
          reason: 'the datasource no longer reads any setting, so the AI '
              'settings modal changes nothing about the request');
      final written = RegExp(r"\$\{_prefix\}([a-z_]+)")
          .allMatches(model)
          .map((m) => 'ai_chat_settings_${m.group(1)}')
          .toSet();
      expect(read.difference(written), isEmpty,
          reason: 'the datasource reads key(s) the model never writes, so the '
              'user\'s choice is silently replaced by the default: '
              '${read.difference(written)}');
    });

    test('both agent-facing settings ride the wire', () {
      expect(datasource.contains("'response_style': responseStyle"), isTrue,
          reason: 'response_style is no longer sent');
      expect(datasource.contains("'emoji_usage': emojiUsage"), isTrue,
          reason: 'emoji_usage is no longer sent');
    });

    test('the gateway declares both fields and builds an instruction', () {
      final gw = _repo('chat-agent-gateway/main.py');
      expect(gw.contains('response_style:'), isTrue,
          reason: 'the gateway no longer accepts response_style, so the app '
              'sends a field that is dropped');
      expect(gw.contains('emoji_usage:'), isTrue,
          reason: 'the gateway no longer accepts emoji_usage');
      expect(gw.contains('response_style_instruction'), isTrue,
          reason: 'the gateway no longer forwards a style instruction');
      // emoji must be honoured INDEPENDENTLY: a voice/telephony/legacy client
      // can send emoji_usage=false with no valid response_style.
      expect(gw.contains('inbound_meta.get("response_style")'), isTrue,
          reason: 'the gateway stopped reading the per-request style, so it '
              'would only ever see a stored default');
    });

    test('the agent appends it to the system prompt, sanitized', () {
      final base = _repo('chat-transfers-service/core/base_agent.py');
      // The NAME appearing is not enough: the import line contains it. The
      // sanitizer has to be what produces the value that gets appended.
      expect(
        RegExp(r'safe_style\s*=\s*sanitize_style_instruction\(\s*'
                r'response_style_instruction\s*\)')
            .hasMatch(base),
        isTrue,
        reason: 'the style instruction reaches the prompt unsanitized — it is '
            'user-controlled text going into a system prompt',
      );
      expect(
        RegExp(r'if safe_style:\s*\n\s*system_prompt \+=').hasMatch(base),
        isTrue,
        reason: 'the sanitized style is no longer appended to the system '
            'prompt, so the setting changes nothing about the answer',
      );
    });
  });
}
