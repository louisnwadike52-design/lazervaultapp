import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Creating a PIN in chat must hand off to the native screen, never collect
/// digits.
///
/// `create_transaction_pin(pin, confirm_pin)` took the new PIN as TOOL
/// ARGUMENTS — read by the LLM and persisted with the tool call in
/// conversation history, writing a brand-new credential into chat history in
/// plaintext. It was done that way because there was nothing to hand off to:
/// the existing pin_prompt opens the pad for SPENDING against a PIN that
/// already exists.
///
/// The chain has four links and a break in any one is silent: the agent emits
/// a sentinel, the service lifts it onto metadata, the cubit moves it into
/// MESSAGE metadata (which is what makes it survive in history), and the
/// content widget renders the card.
void main() {
  String read(String p) => File(p).readAsStringSync();
  String stripComments(String src) => src
      .split('\n')
      .where((l) =>
          !l.trimLeft().startsWith('//') && !l.trimLeft().startsWith('#'))
      .join('\n');

  const card =
      'lib/src/features/microservice_chat/presentation/widgets/chat_pin_setup_card.dart';
  const cubit =
      'lib/src/features/microservice_chat/cubit/microservice_chat_cubit.dart';
  const contents = [
    'lib/src/features/microservice_chat/presentation/widgets/microservice_chat_content.dart',
    'lib/src/features/microservice_chat/presentation/widgets/general_chat_content.dart',
  ];

  test('the card has NO input — it routes to the native screen', () {
    final src = read(card);
    expect(src, contains('AppRoutes.transactionPinSetup'),
        reason: 'the card must open the same native setup screen the account '
            'screens use');
    for (final widget in ['TextField', 'TextFormField', 'PinCodeTextField']) {
      expect(src, isNot(contains(widget)),
          reason: 'a $widget here recreates the defect this card exists to '
              'remove — the PIN must never be typed in the chat');
    }
    expect(src, contains('never typed into this'),
        reason: 'say so plainly; the user is being asked to leave the chat');
  });

  test('every cubit path strips the sentinel AND sets the metadata', () {
    final src = stripComments(read(cubit));
    final strips = RegExp(r"remove\('_pin_setup_pending'\)").allMatches(src).length;
    final sets = RegExp(r"messageMetadata\['pin_setup'\]").allMatches(src).length;
    expect(strips, greaterThan(0), reason: 'the sentinel is never read');
    expect(sets, strips,
        reason: 'a path that strips the sentinel without setting the metadata '
            'silently swallows the hand-off: the agent says setup opened and '
            'nothing opens ($strips strip sites, $sets set sites)');
  });

  test('both chat surfaces render it', () {
    for (final p in contents) {
      final src = stripComments(read(p));
      expect(
          RegExp(r"metadata\?\['pin_setup'\] != null\)\s*\n\s*ChatPinSetupCard\(")
              .hasMatch(src),
          isTrue,
          reason: '$p must render the card UNDER the metadata guard. '
              'Checking that both strings merely appear is satisfied by '
              '`if (false) ChatPinSetupCard(...)`, which renders nothing.');
    }
  });

  test('the sentinel name matches the shared protocol exactly', () {
    // A typo here is invisible: the agent emits, nothing matches, no error.
    var dir = Directory.current;
    File? emit;
    for (var i = 0; i < 6; i++) {
      final f = File('${dir.path}/../chat_services_shared/protocol_emit.py');
      if (f.existsSync()) {
        emit = f;
        break;
      }
      final parent = dir.parent;
      if (parent.path == dir.path) break;
      dir = parent;
    }
    if (emit == null) {
      markTestSkipped('chat_services_shared not checked out beside the app');
      return;
    }
    final py = emit.readAsStringSync();
    expect(py, contains('_PIN_SETUP_SENTINEL_KEY: str = "_pin_setup_pending"'),
        reason: 'the Dart side strips _pin_setup_pending; the python side '
            'must emit that exact key');
    expect(py, contains('def request_pin_setup('),
        reason: 'the emit helper is gone, so no agent can ask for setup');
    expect(py, contains('agent_result["pin_setup"] = entities.pop('),
        reason: 'pop_pending_protocol_payloads must lift it, or the service '
            'never sees it');
  });
}
