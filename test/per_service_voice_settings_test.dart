/// Unit tests for the per-service voice/chat assistant settings
/// model + cubit + in-memory storage. Pure Dart — no widget tests
/// here (the screen + button are covered by Phase 11's
/// per_service_voice_setup_e2e_test.dart).
library;

import 'package:flutter_test/flutter_test.dart';

import 'package:lazervault/src/features/voice/cubit/per_service_voice_settings_cubit.dart';
import 'package:lazervault/src/features/voice/models/per_service_voice_settings.dart';

/// In-memory storage stand-in for the SharedPreferences-backed one.
class _MemStorage implements PerServiceVoiceSettingsStorage {
  final Map<String, PerServiceVoiceSettings> rows = {};

  @override
  Future<PerServiceVoiceSettings?> read(String serviceName) async {
    return rows[serviceName];
  }

  @override
  Future<void> write(PerServiceVoiceSettings settings) async {
    rows[settings.serviceName] = settings;
  }
}

class _RecordingRemoteSync implements PerServiceVoiceSettingsRemoteSync {
  final List<PerServiceVoiceSettings> pushes = [];
  final Object? Function()? errorOn;

  _RecordingRemoteSync({this.errorOn});

  @override
  Future<void> push(PerServiceVoiceSettings settings) async {
    final err = errorOn?.call();
    if (err != null) {
      throw err;
    }
    pushes.add(settings);
  }
}

void main() {
  group('PerServiceVoiceSettings model', () {
    test('defaultFor mints a blank row for the given service', () {
      final s = PerServiceVoiceSettings.defaultFor('crypto');
      expect(s.serviceName, 'crypto');
      expect(s.languageCode, isNull);
      expect(s.voiceId, isNull);
      expect(s.promptHint, '');
      expect(s.isConfigured, isFalse);
      expect(s.hasAnyOverride(), isFalse);
    });

    test('copyWith preserves serviceName', () {
      final s = PerServiceVoiceSettings.defaultFor('crypto')
          .copyWith(languageCode: 'yo');
      expect(s.serviceName, 'crypto');
      expect(s.languageCode, 'yo');
    });

    test('hasAnyOverride is true when any of lang/voice/hint is set', () {
      final base = PerServiceVoiceSettings.defaultFor('x');
      expect(base.hasAnyOverride(), isFalse);
      expect(base.copyWith(languageCode: 'en').hasAnyOverride(), isTrue);
      expect(base.copyWith(voiceId: 'v1').hasAnyOverride(), isTrue);
      expect(base.copyWith(promptHint: 'hint').hasAnyOverride(), isTrue);
      // Whitespace-only hint doesn't count
      expect(base.copyWith(promptHint: '   ').hasAnyOverride(), isFalse);
    });

    test('roundtrips through JSON', () {
      final s = PerServiceVoiceSettings(
        serviceName: 'insurance',
        languageCode: 'ig',
        voiceId: 'yarn-igbo-female',
        promptHint: 'Be concise',
        isConfigured: true,
        updatedAt: '2026-05-31T12:00:00.000Z',
      );
      final round = PerServiceVoiceSettings.fromJsonString(s.toJsonString());
      expect(round, isNotNull);
      expect(round!.serviceName, s.serviceName);
      expect(round.languageCode, s.languageCode);
      expect(round.voiceId, s.voiceId);
      expect(round.promptHint, s.promptHint);
      expect(round.isConfigured, s.isConfigured);
      expect(round.updatedAt, s.updatedAt);
    });

    test('fromJsonString returns null on garbage', () {
      expect(PerServiceVoiceSettings.fromJsonString(null), isNull);
      expect(PerServiceVoiceSettings.fromJsonString(''), isNull);
      expect(
        PerServiceVoiceSettings.fromJsonString('not-json'),
        isNull,
      );
    });

    test('labelForChatService maps known + falls back to raw name', () {
      expect(labelForChatService('crypto'), contains('Crypto'));
      expect(labelForChatService('transfers'), contains('Send'));
      expect(labelForChatService('made_up_service'), 'made_up_service');
    });
  });

  group('PerServiceVoiceSettingsCubit', () {
    test('load reads from storage and emits Loaded', () async {
      final storage = _MemStorage();
      storage.rows['crypto'] = PerServiceVoiceSettings(
        serviceName: 'crypto',
        languageCode: 'ig',
        isConfigured: true,
      );
      final cubit = PerServiceVoiceSettingsCubit(
        serviceName: 'crypto',
        storage: storage,
      );
      await cubit.load();
      final st = cubit.state as PerServiceVoiceSettingsLoaded;
      expect(st.settings.languageCode, 'ig');
      expect(st.settings.isConfigured, isTrue);
      expect(st.dirty, isFalse);
    });

    test('load falls back to default when nothing stored', () async {
      final cubit = PerServiceVoiceSettingsCubit(
        serviceName: 'transfers',
        storage: _MemStorage(),
      );
      await cubit.load();
      final st = cubit.state as PerServiceVoiceSettingsLoaded;
      expect(st.settings.languageCode, isNull);
      expect(st.settings.isConfigured, isFalse);
    });

    test('selectLanguage marks dirty', () async {
      final cubit = PerServiceVoiceSettingsCubit(
        serviceName: 'crypto',
        storage: _MemStorage(),
      );
      await cubit.load();
      cubit.selectLanguage('yo');
      final st = cubit.state as PerServiceVoiceSettingsLoaded;
      expect(st.settings.languageCode, 'yo');
      expect(st.dirty, isTrue);
    });

    test('save writes to storage + clears dirty + sets savedAt', () async {
      final storage = _MemStorage();
      final cubit = PerServiceVoiceSettingsCubit(
        serviceName: 'crypto',
        storage: storage,
      );
      await cubit.load();
      cubit.selectLanguage('yo');
      cubit.setPromptHint('Show charts');
      await cubit.save();
      final st = cubit.state as PerServiceVoiceSettingsLoaded;
      expect(st.dirty, isFalse);
      expect(st.savedAt, isNotNull);
      expect(storage.rows['crypto']!.languageCode, 'yo');
      expect(storage.rows['crypto']!.promptHint, 'Show charts');
      expect(storage.rows['crypto']!.isConfigured, isTrue);
      expect(storage.rows['crypto']!.updatedAt, isNotNull);
    });

    test('save with remoteSync fires push asynchronously', () async {
      final remote = _RecordingRemoteSync();
      final cubit = PerServiceVoiceSettingsCubit(
        serviceName: 'crypto',
        storage: _MemStorage(),
        remoteSync: remote,
      );
      await cubit.load();
      cubit.selectLanguage('yo');
      await cubit.save();
      // Push is fire-and-forget; let the microtask queue drain.
      await Future<void>.delayed(const Duration(milliseconds: 10));
      expect(remote.pushes.length, 1);
      expect(remote.pushes.first.languageCode, 'yo');
    });

    test('save still succeeds locally when remoteSync throws', () async {
      final storage = _MemStorage();
      final remote = _RecordingRemoteSync(
        errorOn: () => StateError('upstream down'),
      );
      final cubit = PerServiceVoiceSettingsCubit(
        serviceName: 'crypto',
        storage: storage,
        remoteSync: remote,
      );
      await cubit.load();
      cubit.selectLanguage('yo');
      await cubit.save();
      // Local save landed, no error in state.
      final st = cubit.state as PerServiceVoiceSettingsLoaded;
      expect(st.dirty, isFalse);
      expect(st.error, isNull);
      expect(storage.rows['crypto']!.languageCode, 'yo');
    });

    test('resetToDefaults clears overrides + writes blank row', () async {
      final storage = _MemStorage();
      storage.rows['crypto'] = PerServiceVoiceSettings(
        serviceName: 'crypto',
        languageCode: 'yo',
        promptHint: 'old hint',
        isConfigured: true,
      );
      final cubit = PerServiceVoiceSettingsCubit(
        serviceName: 'crypto',
        storage: storage,
      );
      await cubit.load();
      await cubit.resetToDefaults();
      final st = cubit.state as PerServiceVoiceSettingsLoaded;
      expect(st.settings.languageCode, isNull);
      expect(st.settings.voiceId, isNull);
      expect(st.settings.promptHint, '');
      expect(st.settings.isConfigured, isFalse);
      expect(storage.rows['crypto']!.languageCode, isNull);
      expect(storage.rows['crypto']!.updatedAt, isNotNull);
    });

    test('isConfigured stays false when saving an all-blank form', () async {
      final storage = _MemStorage();
      final cubit = PerServiceVoiceSettingsCubit(
        serviceName: 'crypto',
        storage: storage,
      );
      await cubit.load();
      // No edits — call save anyway
      await cubit.save();
      expect(storage.rows['crypto']!.isConfigured, isFalse);
    });

    test('selectVoice and setPromptHint each mark dirty', () async {
      final cubit = PerServiceVoiceSettingsCubit(
        serviceName: 'insurance',
        storage: _MemStorage(),
      );
      await cubit.load();
      cubit.selectVoice('eleven-rachel');
      var st = cubit.state as PerServiceVoiceSettingsLoaded;
      expect(st.dirty, isTrue);
      expect(st.settings.voiceId, 'eleven-rachel');

      // Reload to reset dirty
      await cubit.load();
      st = cubit.state as PerServiceVoiceSettingsLoaded;
      expect(st.dirty, isFalse);

      cubit.setPromptHint('please be brief');
      st = cubit.state as PerServiceVoiceSettingsLoaded;
      expect(st.dirty, isTrue);
      expect(st.settings.promptHint, 'please be brief');
    });
  });
}
