import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'account_manager.dart';
import 'haptics_service.dart';
import 'injection_container.dart';
import 'locale_manager.dart';

/// A single saved decoy preset — a label ("market", "travel") + the fake amount
/// shown as the balance when that preset is active.
@immutable
class PanicPreset {
  final String label;
  final double amount;

  const PanicPreset({required this.label, required this.amount});

  Map<String, dynamic> toJson() => {'label': label, 'amount': amount};

  factory PanicPreset.fromJson(Map<String, dynamic> j) => PanicPreset(
        label: (j['label'] ?? '').toString(),
        amount: j['amount'] is num
            ? (j['amount'] as num).toDouble()
            : double.tryParse('${j['amount']}') ?? 0.0,
      );

  @override
  bool operator ==(Object other) =>
      other is PanicPreset && other.label == label && other.amount == amount;

  @override
  int get hashCode => Object.hash(label, amount);
}

/// PANIC BALANCE — a pure DISPLAY decoy for unsafe situations.
///
/// SECURITY CONTRACT: this never touches real balances, available balances,
/// limits, or any money path. It only changes the NUMBER shown on balance
/// widgets while [isCamouflageOn]. A user can show a ₦5,000 decoy and still
/// execute a real ₦50,000 transfer — transaction code reads the real values,
/// never this service.
///
/// Two scopes:
///  - CONFIG (`enabled` + `presets`): server-synced (so the AI assistant can set
///    it and it follows the user across devices), cached locally for instant /
///    offline reads.
///  - VISIBLE toggle (`isVisible` + active preset): DEVICE-LOCAL and persisted, so
///    once triggered the decoy stays shown across app close/reopen until the user
///    toggles it off again (shake / long-press).
///
/// Exposed as a [ChangeNotifier] (GetIt singleton). Balance widgets listen and
/// re-render when the decoy is toggled or reconfigured.
class PanicBalanceService extends ChangeNotifier {
  static const String _kEnabled = 'panic_enabled';
  static const String _kPresets = 'panic_presets';
  static const String _kActiveLabel = 'panic_active_label';
  static const String _kVisible = 'panic_visible';
  // Device-local trigger + sound preferences (how the decoy is toggled, and
  // whether the balance-change animation plays a money-counting sound). These
  // are per-device UX, NOT server-synced config.
  static const String _kShakeTrigger = 'panic_trigger_shake';
  static const String _kLongPressTrigger = 'panic_trigger_longpress';
  static const String _kSound = 'panic_sound_enabled';
  static const String _kSoundChoice = 'panic_sound_choice';
  // Vibrate WHILE the balance-change animation plays (and when the decoy is
  // toggled on). Device-local UX preference, parallel to the sound toggle.
  static const String _kVibration = 'panic_vibration_enabled';

  /// Default balance-animation sound (an already-registered asset).
  static const String _defaultSoundAsset =
      'assets/sounds/panic/money_count.wav';

  /// Selectable balance-animation sounds — label → asset path. All assets are
  /// already registered in pubspec.yaml (`assets/sounds/panic/` and
  /// `assets/sounds/sprayme/`). Surfaced in the settings sound picker.
  final Map<String, String> panicSoundOptions = const {
    'Cash counter': 'assets/sounds/panic/money_count.wav',
    'Cash register': 'assets/sounds/sprayme/cash_register.mp3',
    'Chime': 'assets/sounds/sprayme/chime.mp3',
    'Pop': 'assets/sounds/sprayme/pop.mp3',
  };

  SharedPreferences? _prefs;
  bool _enabled = false;
  List<PanicPreset> _presets = <PanicPreset>[];
  String? _activeLabel;
  bool _visible = false;
  bool _shakeTrigger = true;
  bool _longPressTrigger = true;
  bool _soundEnabled = false;
  String _soundChoice = _defaultSoundAsset;
  bool _vibrationEnabled = false;

  // Config is namespaced per active account + locale so a decoy set up on
  // account A / locale en-NG never leaks onto account B or another locale. The
  // suffix is recomputed whenever the active account or locale changes and every
  // SharedPreferences key is routed through [_k].
  final AccountManager _accountManager;
  final LocaleManager _localeManager;
  StreamSubscription<String?>? _accountSub;
  StreamSubscription<String>? _localeSub;
  String _suffix = '';

  PanicBalanceService({
    AccountManager? accountManager,
    LocaleManager? localeManager,
  })  : _accountManager = accountManager ?? serviceLocator<AccountManager>(),
        _localeManager = localeManager ?? serviceLocator<LocaleManager>() {
    _suffix = _computeSuffix();
    // BehaviorSubjects replay their current value on listen; the guard in
    // [_onScopeChanged] makes that initial replay a no-op (suffix unchanged).
    _accountSub =
        _accountManager.accountIdStream.listen((_) => _onScopeChanged());
    _localeSub = _localeManager.localeStream.listen((_) => _onScopeChanged());
  }

  /// Per-(account, locale) key suffix, non-alphanumerics collapsed to '_'.
  String _computeSuffix() {
    final acct = _accountManager.activeAccountId ?? 'none';
    final loc = _localeManager.currentLocale;
    return '_${acct}_$loc'.replaceAll(RegExp(r'[^A-Za-z0-9]'), '_');
  }

  /// Namespace a base key by the active account + locale.
  String _k(String base) => '$base$_suffix';

  /// Active account or locale changed → reload the now-namespaced config,
  /// re-sync from the server, and notify listeners. No-op when the scope (and
  /// therefore the key suffix) is unchanged.
  void _onScopeChanged() {
    final next = _computeSuffix();
    if (next == _suffix) return;
    _suffix = next;
    unawaited(_reloadScope());
  }

  Future<void> _reloadScope() async {
    await init(); // reloads the namespaced values (and notifies)
    notifyListeners();
    await syncFromServer();
  }

  // Best-effort server sync (so the AI assistant can set the config and it
  // follows the user across devices). Injected via [configureSync] to avoid a DI
  // import cycle. Sync is ALWAYS best-effort: any failure leaves the local config
  // (the source of truth for display) untouched, so the feature works offline.
  String? _syncBaseUrl; // e.g. https://host/api/v1
  Future<String?> Function()? _tokenProvider;

  // ── Reads (synchronous, in-memory; safe on the render path) ──
  bool get enabled => _enabled;
  List<PanicPreset> get presets => List.unmodifiable(_presets);
  bool get isVisible => _visible;
  bool get shakeTriggerEnabled => _shakeTrigger;
  bool get longPressTriggerEnabled => _longPressTrigger;
  bool get soundEnabled => _soundEnabled;
  String get soundChoice => _soundChoice;
  bool get vibrationEnabled => _vibrationEnabled;

  /// The preset currently selected (or the first one as a fallback).
  PanicPreset? get activePreset {
    if (_presets.isEmpty) return null;
    if (_activeLabel != null) {
      for (final p in _presets) {
        if (p.label == _activeLabel) return p;
      }
    }
    return _presets.first;
  }

  /// True only when the decoy should REPLACE the real balance on screen.
  bool get isCamouflageOn => _enabled && _visible && activePreset != null;

  /// The fake amount to show while [isCamouflageOn]. 0 when nothing active.
  double get decoyAmount => activePreset?.amount ?? 0.0;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    final p = _prefs!;
    _enabled = p.getBool(_k(_kEnabled)) ?? false;
    _visible = p.getBool(_k(_kVisible)) ?? false;
    _shakeTrigger = p.getBool(_k(_kShakeTrigger)) ?? true;
    _longPressTrigger = p.getBool(_k(_kLongPressTrigger)) ?? true;
    _soundEnabled = p.getBool(_k(_kSound)) ?? false;
    _soundChoice = p.getString(_k(_kSoundChoice)) ?? _defaultSoundAsset;
    _vibrationEnabled = p.getBool(_k(_kVibration)) ?? false;
    _activeLabel = p.getString(_k(_kActiveLabel));
    final raw = p.getString(_k(_kPresets));
    if (raw != null && raw.isNotEmpty) {
      try {
        final list = jsonDecode(raw) as List;
        _presets = list
            .map((e) => PanicPreset.fromJson(Map<String, dynamic>.from(e as Map)))
            .toList();
      } catch (_) {
        _presets = <PanicPreset>[];
      }
    }
    // Never leave a dangling visible state with no usable preset.
    if (!_enabled || activePreset == null) _visible = false;
    notifyListeners();
  }

  Future<void> _persist() async {
    final p = _prefs;
    if (p == null) return;
    await p.setBool(_k(_kEnabled), _enabled);
    await p.setBool(_k(_kVisible), _visible);
    if (_activeLabel != null) {
      await p.setString(_k(_kActiveLabel), _activeLabel!);
    } else {
      await p.remove(_k(_kActiveLabel));
    }
    await p.setString(
        _k(_kPresets), jsonEncode(_presets.map((e) => e.toJson()).toList()));
    await p.setBool(_k(_kShakeTrigger), _shakeTrigger);
    await p.setBool(_k(_kLongPressTrigger), _longPressTrigger);
    await p.setBool(_k(_kSound), _soundEnabled);
    await p.setString(_k(_kSoundChoice), _soundChoice);
    await p.setBool(_k(_kVibration), _vibrationEnabled);
  }

  /// Enable/disable the phone-shake trigger (device-local UX preference).
  Future<void> setShakeTrigger(bool value) async {
    _shakeTrigger = value;
    await _persist();
    notifyListeners();
  }

  /// Enable/disable the long-press-on-balance trigger (device-local).
  Future<void> setLongPressTrigger(bool value) async {
    _longPressTrigger = value;
    await _persist();
    notifyListeners();
  }

  /// Enable/disable the money-counting sound played as the balance animates.
  Future<void> setSoundEnabled(bool value) async {
    _soundEnabled = value;
    await _persist();
    notifyListeners();
    unawaited(_pushToServer());
  }

  /// Choose which sound plays as the balance animates up (a credit). [assetPath]
  /// should be one of [panicSoundOptions] values.
  Future<void> setSoundChoice(String assetPath) async {
    _soundChoice = assetPath;
    await _persist();
    notifyListeners();
    unawaited(_pushToServer());
  }

  /// Enable/disable vibration WHILE the balance-change animation plays (and a
  /// confirming buzz when the decoy is toggled on). Device-local UX preference.
  Future<void> setVibrationEnabled(bool value) async {
    _vibrationEnabled = value;
    await _persist();
    notifyListeners();
  }

  /// Trigger handler (shake / long-press). Flips the on-screen decoy. No-op when
  /// the feature is off or there's no usable preset — so a stray shake never
  /// surprises a user who hasn't set it up.
  Future<void> toggle() async {
    if (!_enabled || activePreset == null) return;
    // Tactile confirmation FIRST — fire the buzz before flipping the on-screen
    // state so the user feels the gesture register the instant it lands (works
    // for both triggers: long-press on the balance and the phone-shake handler).
    Haptics.success();
    final switchingToDecoy = !_visible; // about to SHOW the decoy
    _visible = !_visible;
    await _persist();
    notifyListeners();
    // When vibration-on-animation is on, a short buzz pattern marks the switch
    // INTO the panic/decoy balance (the decoy number itself snaps for security,
    // so this is the tactile cue that "you changed to panic balance").
    if (switchingToDecoy && _vibrationEnabled) {
      _buzzDecoySwitch();
    }
  }

  /// A brief 3-pulse vibration pattern announcing the switch into the decoy.
  void _buzzDecoySwitch() {
    var n = 0;
    Timer.periodic(const Duration(milliseconds: 160), (t) {
      if (n++ >= 3) {
        t.cancel();
        return;
      }
      Haptics.warning();
    });
  }

  Future<void> setEnabled(bool value) async {
    _enabled = value;
    if (!value) _visible = false; // turning the feature off also hides the decoy
    await _persist();
    notifyListeners();
    unawaited(_pushToServer());
  }

  Future<void> setActivePreset(String label) async {
    _activeLabel = label;
    await _persist();
    notifyListeners();
    unawaited(_pushToServer());
  }

  /// Add or update a preset (matched by [replaceLabel] or its own label).
  Future<void> upsertPreset(PanicPreset preset, {String? replaceLabel}) async {
    final key = replaceLabel ?? preset.label;
    final idx = _presets.indexWhere((p) => p.label == key);
    if (idx >= 0) {
      _presets[idx] = preset;
      if (_activeLabel == key) _activeLabel = preset.label;
    } else {
      _presets.add(preset);
    }
    _activeLabel ??= preset.label;
    await _persist();
    notifyListeners();
    unawaited(_pushToServer());
  }

  Future<void> removePreset(String label) async {
    _presets.removeWhere((p) => p.label == label);
    if (_activeLabel == label) {
      _activeLabel = _presets.isNotEmpty ? _presets.first.label : null;
    }
    if (_presets.isEmpty) _visible = false;
    await _persist();
    notifyListeners();
    unawaited(_pushToServer());
  }

  /// Replace local config from the backend (server is the source of truth for
  /// CONFIG). Leaves the device-local VISIBLE toggle intact unless the feature
  /// became disabled. Called after fetching settings / after the AI changes them.
  Future<void> applyServerConfig({
    required bool enabled,
    required List<PanicPreset> presets,
    String? activeLabel,
  }) async {
    _enabled = enabled;
    _presets = List<PanicPreset>.from(presets);
    if (activeLabel != null && activeLabel.isNotEmpty) _activeLabel = activeLabel;
    if (!_enabled || activePreset == null) _visible = false;
    await _persist();
    notifyListeners();
  }

  /// Snapshot of the CONFIG to push to the backend.
  Map<String, dynamic> configToJson() => {
        'enabled': _enabled,
        'active_label': _activeLabel,
        'presets': _presets.map((e) => e.toJson()).toList(),
        'sound_enabled': _soundEnabled,
        'sound_choice': _soundChoice,
      };

  // ── Best-effort server sync ──
  /// Wire up sync. [baseUrl] is the `.../api/v1` base; [accessTokenProvider]
  /// yields the current bearer token (or null when unauthenticated).
  void configureSync({
    required String baseUrl,
    required Future<String?> Function() accessTokenProvider,
  }) {
    _syncBaseUrl = baseUrl;
    _tokenProvider = accessTokenProvider;
  }

  Uri? get _settingsUri {
    final base = _syncBaseUrl;
    if (base == null || base.isEmpty) return null;
    return Uri.parse('${base.replaceAll(RegExp(r'/+$'), '')}/panic/settings');
  }

  /// Pull the CONFIG from the server and merge it locally. Never throws.
  Future<void> syncFromServer() async {
    final uri = _settingsUri;
    final token = await _tokenProvider?.call();
    if (uri == null || token == null || token.isEmpty) return;
    try {
      final resp = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
      }).timeout(const Duration(seconds: 8));
      if (resp.statusCode != 200) return;
      final body = jsonDecode(resp.body) as Map<String, dynamic>;
      final presets = ((body['presets'] as List?) ?? [])
          .map((e) => PanicPreset.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
      await applyServerConfig(
        enabled: body['enabled'] == true,
        presets: presets,
        activeLabel: (body['active_label'] as String?),
      );
    } catch (_) {
      // best-effort — keep local config
    }
  }

  /// Push the CONFIG to the server. Never throws.
  Future<void> _pushToServer() async {
    final uri = _settingsUri;
    final token = await _tokenProvider?.call();
    if (uri == null || token == null || token.isEmpty) return;
    try {
      await http
          .put(uri,
              headers: {
                'Authorization': 'Bearer $token',
                'Content-Type': 'application/json',
              },
              body: jsonEncode(configToJson()))
          .timeout(const Duration(seconds: 8));
    } catch (_) {
      // best-effort — local stays source of truth
    }
  }

  @override
  void dispose() {
    _accountSub?.cancel();
    _localeSub?.cancel();
    super.dispose();
  }
}
