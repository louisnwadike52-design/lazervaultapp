import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Per-service chat icons and voice buttons, each independently admin-toggled,
// plus a master switch per surface that leaves only the CENTRAL assistant.
//
// The central assistant (NOVA) is its own bottom-nav screen, not one of these
// icons, so turning every per-service entry point off leaves exactly it —
// which is what the master switch is for.
//
// The two widgets do NOT agree on service names ('Auto-Save' vs 'autosave',
// 'Currency Exchange' vs 'exchange'), so each normalises its own name into a
// slug. An admin never has to know which spelling a surface happens to use.

void main() {
  setUp(() async {
    // CLEAR THROUGH THE LIVE INSTANCE. setMockInitialValues only seeds the
    // store before the first getInstance(); after that it is a no-op, so
    // state leaks between tests and a toggle set by one test silently
    // decides the next one's result.
    SharedPreferences.setMockInitialValues({});
    // debugResetForTest, not init(): init() is `_prefs ??= ...`, so once it
    // has bound a store it never rebinds, and every later test reads the
    // FIRST test's values. State leaked exactly that way here — a master
    // switch set by one test decided the next one's result.
    await FeatureFlags.debugResetForTest();
  });

  group('slugging absorbs the inconsistent naming', () {
    test('case, spaces and punctuation are stripped', () {
      expect(FeatureFlags.assistantSlug('Auto-Save'), 'autosave');
      expect(FeatureFlags.assistantSlug('autosave'), 'autosave');
      expect(FeatureFlags.assistantSlug('Currency Exchange'), 'currencyexchange');
      expect(FeatureFlags.assistantSlug('QR Pay'), 'qrpay');
      expect(FeatureFlags.assistantSlug('split_bills'), 'splitbills');
      expect(FeatureFlags.assistantSlug('p2p_chat'), 'p2pchat');
    });

    test('the two spellings of one service agree where the names match', () {
      // 'Batch Transfer' is passed to BOTH widgets; one toggle vocabulary.
      expect(FeatureFlags.assistantSlug('Batch Transfer'),
          FeatureFlags.assistantSlug('batch transfer'));
    });
  });

  group('defaults', () {
    test('every entry point is visible until an admin says otherwise', () {
      expect(FeatureFlags.chatIconVisible('Crypto'), isTrue);
      expect(FeatureFlags.voiceAgentVisible('crypto'), isTrue);
      expect(FeatureFlags.chatIconVisible('ServiceAddedTomorrow'), isTrue);
    });

    test('an empty service name never hides the entry point', () {
      // A slug we cannot compute must not silently remove a user's way in.
      expect(FeatureFlags.chatIconVisible(''), isTrue);
      expect(FeatureFlags.voiceAgentVisible('!!!'), isTrue);
    });
  });

  group('per-service toggles', () {
    test('one service off does not affect another', () async {
      await FeatureFlags.applyRemoteSnapshot({
        'chat_icon_crypto_enabled': 'false',
      });
      expect(FeatureFlags.chatIconVisible('Crypto'), isFalse);
      expect(FeatureFlags.chatIconVisible('Escrow Pay'), isTrue);
    });

    test('chat and voice are independent for the same service', () async {
      await FeatureFlags.applyRemoteSnapshot({
        'chat_icon_crypto_enabled': 'false',
      });
      expect(FeatureFlags.chatIconVisible('Crypto'), isFalse);
      expect(FeatureFlags.voiceAgentVisible('crypto'), isTrue,
          reason: 'turning off the chat icon must not mute the voice agent');
    });

    test('a malformed value leaves the entry point VISIBLE', () async {
      await FeatureFlags.applyRemoteSnapshot({
        'voice_agent_crypto_enabled': 'off',
      });
      expect(FeatureFlags.voiceAgentVisible('crypto'), isTrue,
          reason: 'a typo must not remove a working assistant');
    });
  });

  group('master switches', () {
    test('chat master off hides every per-service chat icon', () async {
      await FeatureFlags.applyRemoteSnapshot({
        'chat_icon_all_enabled': 'false',
      });
      for (final s in ['Crypto', 'Escrow Pay', 'Invoices', 'Anything']) {
        expect(FeatureFlags.chatIconVisible(s), isFalse);
      }
    });

    test('chat master does not mute voice', () async {
      await FeatureFlags.applyRemoteSnapshot({
        'chat_icon_all_enabled': 'false',
      });
      expect(FeatureFlags.voiceAgentVisible('crypto'), isTrue);
    });

    test('voice master off hides every per-service voice button', () async {
      await FeatureFlags.applyRemoteSnapshot({
        'voice_agent_all_enabled': 'false',
      });
      expect(FeatureFlags.voiceAgentVisible('crypto'), isFalse);
      expect(FeatureFlags.voiceAgentVisible('rmb'), isFalse);
      expect(FeatureFlags.chatIconVisible('Crypto'), isTrue);
    });

    test('the master WINS over a per-service enable', () async {
      // "All off except the ones I also ticked" is not what an admin who
      // disabled everything is asking for.
      await FeatureFlags.applyRemoteSnapshot({
        'chat_icon_all_enabled': 'false',
        'chat_icon_crypto_enabled': 'true',
      });
      expect(FeatureFlags.chatIconVisible('Crypto'), isFalse);
    });

    test('turning the master back on restores the per-service state',
        () async {
      await FeatureFlags.applyRemoteSnapshot({
        'chat_icon_all_enabled': 'false',
        'chat_icon_crypto_enabled': 'false',
        'chat_icon_rmb_enabled': 'true',
      });
      await FeatureFlags.applyRemoteSnapshot({
        'chat_icon_all_enabled': 'true',
      });
      expect(FeatureFlags.chatIconVisible('Crypto'), isFalse,
          reason: 'its own toggle was off and must stay off');
      expect(FeatureFlags.chatIconVisible('rmb'), isTrue);
    });
  });
}
