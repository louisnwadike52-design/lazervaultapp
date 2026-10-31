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

  test('the sentinel is stripped and set in exactly ONE shared place', () {
    // The invariant is unchanged — a path that strips the sentinel without
    // setting the metadata silently swallows the hand-off — but as of
    // 31 Oct 2026 it is structural rather than counted.
    //
    // WHY IT CHANGED: this cubit had five response branches, each
    // hand-rolling its own sentinel list. Two of them were wrong. The media
    // branch drained NOTHING, so a money move begun with a voice note or a
    // photo lost `_pin_prompt_pending` and the PIN pad could never open; one
    // of the two PIN-round-trip branches drained four sentinels and omitted
    // pin_prompt and pin_setup, stranding a user mid-batch. The old
    // strips == sets count passed throughout, because both sides of a
    // branch that handles neither are zero.
    //
    // All branches now route through `_drainSentinelMetadata`, so the count
    // to assert is ONE: a second strip site means a branch has gone back to
    // hand-rolling, which is exactly how the two defects above arose.
    final src = stripComments(read(cubit));
    final strips =
        RegExp(r"remove\('_pin_setup_pending'\)").allMatches(src).length;
    expect(strips, 1,
        reason: 'expected exactly one strip site (the shared drain helper), '
            'found $strips. More than one means a response branch is '
            'building its own payload list again and can silently omit a '
            'sentinel; zero means the sentinel is never read at all.');

    final sets = RegExp(r"out\['pin_setup'\]").allMatches(src).length;
    expect(sets, strips,
        reason: 'the shared helper strips the sentinel but never writes it to '
            'the metadata it returns, so the hand-off is swallowed for every '
            'path at once ($strips strip sites, $sets set sites)');

    // And the helper every branch must go through, by name.
    final drains =
        RegExp(r'_drainSentinelMetadata\(').allMatches(src).length;
    expect(drains, greaterThanOrEqualTo(6),
        reason: 'expected the declaration plus one call per response branch '
            '(five at the time of writing); found $drains. A branch that '
            'stopped calling it carries no pin_setup and no pin_prompt.');
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

  test('the card is REBUILT from stored history, not just rendered live', () {
    // Message metadata alone is not enough. Reopening a thread goes through
    // hydrateChatWidgetMetadata, and a key that mapper does not copy forward
    // degrades silently to a grey bubble — the exact bug that file was
    // written to fix for receipts. The hand-off is worse to lose than a
    // receipt: it is an action the user may not have taken yet.
    const hydration =
        'lib/src/features/microservice_chat/data/repositories/chat_widget_metadata_hydration.dart';
    final src = read(hydration);
    expect(src, contains("kChatMetaPinSetup = 'pin_setup'"));
    expect(src, contains("'_pin_setup_pending': kChatMetaPinSetup"),
        reason: 'the direct path carries it as a sentinel in entities; '
            'without this entry a per-service chat loses it on reload');
    // It must be in the always-hydrate list, not merely declared.
    final i = src.indexOf('for (final key in const [');
    final block = src.substring(i, src.indexOf(']', i));
    expect(block, contains('kChatMetaPinSetup'),
        reason: 'declaring the key without hydrating it is the same silent '
            'degradation');
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
