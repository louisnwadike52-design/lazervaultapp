import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/services/voice_keyterms_cache.dart';
import 'package:lazervault/core/services/user_switch_purge.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The recogniser hint that boosts the names this user sends money to.
///
/// The gateway's `get_keyterms` has ranked per-speaker terms above its curated
/// Nigerian-name lists since it was written — "the exact spellings in this
/// user's own address book" against "a guess at common Nigerian names" — and
/// NOTHING ever supplied them. The parameter, the budget priority and the
/// docstring all existed; no caller passed a list. The failure its own
/// docstring names: "send money to Onah Praiz" transcribed as "praise honor".
void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('stores first names only', () async {
    await VoiceKeytermsCache.remember(['Onah Praiz', 'Obinna Okeke']);
    // A keyterm boost works on the word, so a surname only spends the budget —
    // and the budget is a Deepgram URL whose length cap, once exceeded, fails
    // the WebSocket handshake and takes STT down for the whole session.
    expect(await VoiceKeytermsCache.read(), ['Onah', 'Obinna']);
  });

  test('de-duplicates case-insensitively', () async {
    await VoiceKeytermsCache.remember(['Grace Ade', 'grace okon', 'GRACE B']);
    expect(await VoiceKeytermsCache.read(), ['Grace']);
  });

  test('keeps hyphens and apostrophes, strips digits', () async {
    await VoiceKeytermsCache.remember(
        ["Chiamaka-Nwosu Eze", "O'Brien Hall", '2083014282']);
    expect(await VoiceKeytermsCache.read(), ['Chiamaka-Nwosu', "O'Brien"]);
  });

  test('never stores an account number', () async {
    // Would not help recognition, and belongs in no device-local cache.
    await VoiceKeytermsCache.remember(['0123456789', '  ', '9']);
    expect(await VoiceKeytermsCache.read(), isEmpty);
  });

  test('caps the list so the client is never what overflows the URL', () async {
    final many = List.generate(
        100,
        (i) => 'Name${String.fromCharCode(65 + i % 26)}'
            '${String.fromCharCode(97 + i ~/ 26)}');
    await VoiceKeytermsCache.remember(many);
    final got = await VoiceKeytermsCache.read();
    expect(got.length, lessThanOrEqualTo(40));
    // The server caps at 40 too; the client staying at or under it means the
    // server never has to silently drop what we sent.
    expect(got.length, 40);
  });

  test('an empty cache is not an error', () async {
    // The session then runs on the gateway's curated terms, exactly as it did
    // before any of this existed. Nothing downstream requires the cache.
    expect(await VoiceKeytermsCache.read(), isEmpty);
    await VoiceKeytermsCache.remember(const []);
    expect(await VoiceKeytermsCache.read(), isEmpty);
  });

  test('is purged on user switch', () async {
    // One person's address book must never boost another person's speech, and
    // these are real names of real people the previous user pays.
    expect(
      kPerUserStorageKeys,
      contains('voice_recipient_keyterms'),
      reason: 'the keyterms cache survives a user switch unless it is listed '
          'with the other per-account caches',
    );
  });
}
