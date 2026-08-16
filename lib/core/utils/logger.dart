import 'dart:developer' as developer;

import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:lazervault/core/services/remote_log_sink.dart';

/// Simple logger for the LazerVault app.
///
/// Every call logs to the local `dart:developer` console AND — for
/// info/warning/error and explicit [event]s — forwards to [RemoteLogSink] so
/// the line is shipped to our Loki server and readable for deployed store
/// devices. `debug` stays console-only to avoid flooding Loki. Remote
/// forwarding is fail-silent and best-effort; it never affects the caller.
class AppLogger {
  static const String _tag = 'LazerVault';

  static void info(String message,
      {Object? error,
      StackTrace? stackTrace,
      String flow = 'app',
      Map<String, dynamic>? fields}) {
    developer.log(
      message,
      name: _tag,
      time: DateTime.now(),
      level: 500, // INFO level
      error: error,
      stackTrace: stackTrace,
    );
    RemoteLogSink.instance.log(
      level: 'info',
      flow: flow,
      message: message,
      fields: _withError(fields, error),
    );
  }

  static void warning(String message,
      {Object? error,
      StackTrace? stackTrace,
      String flow = 'app',
      Map<String, dynamic>? fields}) {
    developer.log(
      message,
      name: _tag,
      time: DateTime.now(),
      level: 900, // WARNING level
      error: error,
      stackTrace: stackTrace,
    );
    RemoteLogSink.instance.log(
      level: 'warn',
      flow: flow,
      message: message,
      fields: _withError(fields, error),
    );
  }

  static void error(String message,
      {Object? error,
      StackTrace? stackTrace,
      String flow = 'app',
      Map<String, dynamic>? fields}) {
    developer.log(
      message,
      name: _tag,
      time: DateTime.now(),
      level: 1000, // ERROR level
      error: error,
      stackTrace: stackTrace,
    );
    RemoteLogSink.instance.log(
      level: 'error',
      flow: flow,
      message: message,
      fields: _withError(fields, error),
    );
  }

  static void debug(String message, {Object? error, StackTrace? stackTrace}) {
    // PROD hygiene: debug is console-only (never Loki), so drop it entirely in
    // release builds — no debug noise on store devices. info/warn/error remain.
    if (kReleaseMode) return;
    developer.log(
      message,
      name: _tag,
      time: DateTime.now(),
      level: 300, // FINE level (debug)
      error: error,
      stackTrace: stackTrace,
    );
    // Debug stays console-only — not shipped to Loki.
  }

  /// Structured breadcrumb for a named flow (e.g. `biometric_login`,
  /// `voice_txpin_settings`). Console + Loki. Use for step-by-step
  /// observability of a flow the way we trace money paths on the backend.
  static void event(
    String flow,
    String message, {
    String level = 'info',
    String? screen,
    Map<String, dynamic>? fields,
  }) {
    developer.log(
      '[$flow] $message${fields != null ? ' $fields' : ''}',
      name: _tag,
      time: DateTime.now(),
      level: level == 'error' ? 1000 : (level == 'warn' ? 900 : 500),
    );
    RemoteLogSink.instance.log(
      level: level,
      flow: flow,
      message: message,
      screen: screen,
      fields: fields,
    );
  }

  static Map<String, dynamic>? _withError(
      Map<String, dynamic>? fields, Object? error) {
    if (error == null) return fields;
    return {...?fields, 'error': error.toString()};
  }
}
