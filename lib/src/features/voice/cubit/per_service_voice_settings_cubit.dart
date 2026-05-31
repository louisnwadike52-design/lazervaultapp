/// Per-service voice/chat preferences cubit.
///
/// One instance per (user × service) — Flutter typically holds one
/// cubit per screen, scoped via BlocProvider. The cubit reads + writes
/// SharedPreferences synchronously (fast UI), and fires an unawaited
/// backend sync (UpdateVoicePreferences RPC) on each save so the
/// downstream chat-*-service agent picks up the user's preferences
/// on the next turn.
///
/// This is intentionally separate from VoiceSettingsCubit (which is
/// the general-voice singleton). Each service gets its own bucket;
/// the user can configure them independently.
library;

import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/per_service_voice_settings.dart';

abstract class PerServiceVoiceSettingsState {
  const PerServiceVoiceSettingsState();
}

class PerServiceVoiceSettingsInitial extends PerServiceVoiceSettingsState {
  const PerServiceVoiceSettingsInitial();
}

class PerServiceVoiceSettingsLoading extends PerServiceVoiceSettingsState {
  const PerServiceVoiceSettingsLoading();
}

class PerServiceVoiceSettingsLoaded extends PerServiceVoiceSettingsState {
  final PerServiceVoiceSettings settings;
  final bool dirty;
  final bool saving;
  final String? savedAt;
  final String? error;

  const PerServiceVoiceSettingsLoaded({
    required this.settings,
    this.dirty = false,
    this.saving = false,
    this.savedAt,
    this.error,
  });

  PerServiceVoiceSettingsLoaded copyWith({
    PerServiceVoiceSettings? settings,
    bool? dirty,
    bool? saving,
    String? savedAt,
    String? error,
    bool clearError = false,
  }) {
    return PerServiceVoiceSettingsLoaded(
      settings: settings ?? this.settings,
      dirty: dirty ?? this.dirty,
      saving: saving ?? this.saving,
      savedAt: savedAt ?? this.savedAt,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

/// Storage interface — keeps the cubit easy to test without touching
/// SharedPreferences singletons.
abstract class PerServiceVoiceSettingsStorage {
  Future<PerServiceVoiceSettings?> read(String serviceName);
  Future<void> write(PerServiceVoiceSettings settings);
}

class SharedPrefsPerServiceVoiceSettingsStorage
    implements PerServiceVoiceSettingsStorage {
  static const String _prefix = 'per_service_voice/';

  @override
  Future<PerServiceVoiceSettings?> read(String serviceName) async {
    final prefs = await SharedPreferences.getInstance();
    return PerServiceVoiceSettings.fromJsonString(
      prefs.getString('$_prefix$serviceName'),
    );
  }

  @override
  Future<void> write(PerServiceVoiceSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      '$_prefix${settings.serviceName}',
      settings.toJsonString(),
    );
  }
}

/// Optional remote sync — fires UpdateVoicePreferences on the
/// core-gateway. The cubit never blocks save UX on this; a failure
/// just logs and the next save retries. Inject null in tests.
abstract class PerServiceVoiceSettingsRemoteSync {
  Future<void> push(PerServiceVoiceSettings settings);
}

class HttpPerServiceVoiceSettingsRemoteSync
    implements PerServiceVoiceSettingsRemoteSync {
  final Uri endpoint;
  final Future<String> Function() bearerProvider;
  final http.Client _client;

  HttpPerServiceVoiceSettingsRemoteSync({
    required this.endpoint,
    required this.bearerProvider,
    http.Client? client,
  }) : _client = client ?? http.Client();

  @override
  Future<void> push(PerServiceVoiceSettings settings) async {
    final token = await bearerProvider();
    final resp = await _client.post(
      endpoint,
      headers: {
        'Content-Type': 'application/json',
        if (token.isNotEmpty) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode(settings.toJson()),
    );
    if (resp.statusCode >= 400) {
      throw StateError(
        'UpdateVoicePreferences returned ${resp.statusCode}: ${resp.body}',
      );
    }
  }
}

class PerServiceVoiceSettingsCubit
    extends Cubit<PerServiceVoiceSettingsState> {
  final String serviceName;
  final PerServiceVoiceSettingsStorage storage;
  final PerServiceVoiceSettingsRemoteSync? remoteSync;

  PerServiceVoiceSettingsCubit({
    required this.serviceName,
    required this.storage,
    this.remoteSync,
  }) : super(const PerServiceVoiceSettingsInitial());

  /// Read SharedPreferences + emit Loaded with whatever's stored
  /// (or the default if nothing yet).
  Future<void> load() async {
    emit(const PerServiceVoiceSettingsLoading());
    final stored = await storage.read(serviceName);
    final settings = stored ?? PerServiceVoiceSettings.defaultFor(serviceName);
    emit(PerServiceVoiceSettingsLoaded(settings: settings));
  }

  void selectLanguage(String? code) {
    final s = state;
    if (s is! PerServiceVoiceSettingsLoaded) return;
    emit(s.copyWith(
      settings: s.settings.copyWith(languageCode: code),
      dirty: true,
      clearError: true,
    ));
  }

  void selectVoice(String? voiceId) {
    final s = state;
    if (s is! PerServiceVoiceSettingsLoaded) return;
    emit(s.copyWith(
      settings: s.settings.copyWith(voiceId: voiceId),
      dirty: true,
      clearError: true,
    ));
  }

  void setPromptHint(String hint) {
    final s = state;
    if (s is! PerServiceVoiceSettingsLoaded) return;
    emit(s.copyWith(
      settings: s.settings.copyWith(promptHint: hint),
      dirty: true,
      clearError: true,
    ));
  }

  /// Reset to the in-flight server state (drop dirty edits).
  Future<void> revert() async {
    await load();
  }

  /// Clear ALL overrides for this service. Mirrors a "use default
  /// general voice settings" button.
  Future<void> resetToDefaults() async {
    final cleared = PerServiceVoiceSettings.defaultFor(serviceName)
        .copyWith(updatedAt: DateTime.now().toUtc().toIso8601String());
    await storage.write(cleared);
    if (remoteSync != null) {
      unawaited(_safeRemoteSync(cleared));
    }
    emit(PerServiceVoiceSettingsLoaded(
      settings: cleared,
      dirty: false,
      savedAt: cleared.updatedAt,
    ));
  }

  /// Persist locally + push to backend. Backend failures don't block
  /// the local save — the next save retries the sync.
  Future<void> save() async {
    final s = state;
    if (s is! PerServiceVoiceSettingsLoaded) return;
    emit(s.copyWith(saving: true, clearError: true));
    final stamped = s.settings.copyWith(
      isConfigured: s.settings.hasAnyOverride(),
      updatedAt: DateTime.now().toUtc().toIso8601String(),
    );
    try {
      await storage.write(stamped);
    } catch (e) {
      emit(s.copyWith(saving: false, error: 'Could not save locally: $e'));
      return;
    }
    if (remoteSync != null) {
      // Fire-and-forget; the cubit doesn't block save UX on remote
      // success. Errors flow into the next-attempt retry logic at the
      // service level.
      unawaited(_safeRemoteSync(stamped));
    }
    emit(PerServiceVoiceSettingsLoaded(
      settings: stamped,
      dirty: false,
      savedAt: stamped.updatedAt,
    ));
  }

  Future<void> _safeRemoteSync(PerServiceVoiceSettings s) async {
    try {
      await remoteSync!.push(s);
    } catch (_) {
      // Logged at the remote sync layer; the next save retries.
    }
  }
}
