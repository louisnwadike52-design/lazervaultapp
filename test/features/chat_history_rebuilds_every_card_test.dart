import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

/// Every card the gateway PERSISTS must be REBUILT when history reloads.
///
/// The defect this pins: a "how are my finances" answer drew charts live and
/// came back as a wall of text after reopening the app. The gateway persisted
/// the card correctly — chat-agent-gateway/main.py writes
/// `response_metadata["analytics_card"]` and copies it into the Redis
/// fast-path — but the central chat's history rebuild handled
/// receipt_card / qr_card / recipient_card and silently skipped analytics_card.
/// The data was there the whole time; nothing read it.
///
/// This is a CONTRACT ACROSS A LANGUAGE BOUNDARY, so it is checked by reading
/// both sources. A unit test on either side alone cannot see the mismatch, and
/// the next card someone adds to the gateway would reproduce the bug exactly.
void main() {
  test('the app rebuilds every card key the gateway persists', () {
    final root = Directory.current.parent.path; // lazervaultapp -> repo root
    final gateway = File('$root/chat-agent-gateway/main.py');
    final repo = File(
      '${Directory.current.path}/lib/src/features/ai_chats/data/repository/ai_chat_repository_impl.dart',
    );

    if (!gateway.existsSync()) {
      // The app repo is cloned on its own in CI; nothing to compare against.
      return;
    }
    expect(repo.existsSync(), isTrue,
        reason: 'central chat repository not found at ${repo.path}');

    final gatewaySrc = gateway.readAsStringSync();
    final repoSrc = repo.readAsStringSync();

    // Keys the gateway writes into the persisted assistant-turn metadata.
    final persisted = RegExp(r'response_metadata\["(\w+)"\]')
        .allMatches(gatewaySrc)
        .map((m) => m.group(1)!)
        .toSet();

    expect(persisted, isNotEmpty,
        reason: 'found no response_metadata[...] writes — did main.py move?');

    // Deliberately NOT rebuilt, each for a stated reason. Anything else that
    // the gateway persists must come back, or it vanishes on reopen.
    const liveOnly = <String>{
      // A PIN pad is a live CTA, not a history artifact: restoring one would
      // reopen a pad for a transfer that has already settled. It IS parsed and
      // then suppressed, so it appears in the source either way.
      'pin_prompt',
      // "Visual feedback for voice mode UI overlays" — a transient overlay
      // belonging to the voice HUD, not a card in the text transcript. The
      // text chat has no such field and should not grow one.
      'visual_feedback',
    };

    final missing = <String>[];
    for (final key in persisted) {
      if (liveOnly.contains(key)) continue;
      if (!repoSrc.contains("asMap('$key')") &&
          !repoSrc.contains("'$key'") &&
          !repoSrc.contains('"$key"')) {
        missing.add(key);
      }
    }

    expect(missing, isEmpty,
        reason: 'the gateway persists these on an assistant turn but the '
            'central chat never rebuilds them from history, so they vanish on '
            'reopen: ${missing.join(", ")}');
  });

  test('analytics_card specifically is rebuilt — the reported regression', () {
    final repo = File(
      '${Directory.current.path}/lib/src/features/ai_chats/data/repository/ai_chat_repository_impl.dart',
    );
    final src = repo.readAsStringSync();
    expect(src.contains("asMap('analytics_card')"), isTrue,
        reason: 'history must rebuild analytics_card or charts disappear on '
            'the next login');
    expect(src.contains('analyticsCard: analyticsCard'), isTrue,
        reason: 'the rebuilt card must actually reach the message entity');
  });
}
