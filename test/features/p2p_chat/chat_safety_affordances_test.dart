import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// App Store Review Guideline 1.2 requires an app carrying user-generated
/// content to offer four things. This chat carries text AND images between
/// users (p2p_chat_media_upload_service.dart), so it applies:
///
///   1. a method for filtering objectionable material  — ChatSecurityKeyword,
///      server-side, predates this
///   2. a mechanism to report offensive content        — added here
///   3. the ability to block abusive users             — added here
///   4. published contact information                  — lazervault.app/support
///
/// Two of the four were missing at the point of submission. These tests pin the
/// two that were added, because removing a safety affordance is the kind of
/// change that looks harmless in a diff and costs a rejection.
void main() {
  late String page;
  late String menu;
  late String cubit;
  late String repo;

  setUpAll(() {
    const base = 'lib/src/features/p2p_chat';
    page = File('$base/presentation/pages/p2p_chat_page.dart').readAsStringSync();
    menu = File('$base/presentation/widgets/p2p_chat_safety_menu.dart')
        .readAsStringSync();
    cubit =
        File('$base/presentation/cubit/p2p_chat_cubit.dart').readAsStringSync();
    repo = File('$base/domain/repositories/p2p_chat_repository.dart')
        .readAsStringSync();
  });

  test('the chat screen offers both report and block', () {
    expect(page.contains('P2pChatSafetyMenu'), isTrue,
        reason: 'the safety menu is no longer mounted in the chat app bar');
    expect(menu.contains("value: 'report'"), isTrue);
    expect(menu.contains("value: 'block'"), isTrue);
  });

  test('both actions reach the server, not just local state', () {
    // Hiding a thread locally would leave the blocked user still able to send,
    // which is the opposite of what the person asked for.
    for (final m in ['blockParticipant', 'unblockParticipant', 'reportConversation']) {
      expect(repo.contains(m), isTrue,
          reason: '$m is missing from the repository contract');
    }
    for (final m in ['blockPeer', 'unblockPeer', 'reportPeer']) {
      expect(cubit.contains('Future<bool> $m('), isTrue,
          reason: '$m is missing from the cubit');
    }
  });

  test('blocking is confirmed before it happens, and names who', () {
    // "Block this user?" with no name is how the wrong person gets blocked.
    expect(menu.contains(r"Block $peerName?"), isTrue);
    expect(menu.contains('showDialog<bool>'), isTrue);
  });

  test('a failure shows a generic message, never the raw error', () {
    // House rule: users see something generic, the detail goes to the logs.
    expect(menu.contains('Something went wrong. Please try again.'), isTrue);
    expect(RegExp(r'\$e\b').hasMatch(menu), isFalse,
        reason: 'the raw error is being rendered into the UI');
    // And the cubit swallows + logs rather than rethrowing into a screen.
    expect(cubit.contains("debugPrint('P2PChatCubit: block failed:"), isTrue);
  });
}
