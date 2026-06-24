import 'dart:io';
import 'package:flutter/services.dart';

/// Thin Dart wrapper over the native Android Host Card Emulation (HCE) service
/// (`com.lazervault.app/hce`). When a Lazervault receiver opens the "Receive
/// Payment" screen we load the session's NDEF payload into the emulated tag so
/// any payer phone — Android (NfcManager) or iPhone (CoreNFC) — can tap to read
/// it, exactly like tapping a physical NFC sticker.
///
/// Android-only: Apple forbids third-party HCE, so on iOS every call is a no-op
/// and [isSupported] returns false (the receiver screen then uses Session ID
/// mode instead). All methods are defensive — a failure never throws into the
/// payment UI, it just reports "unsupported" so the UI can fall back.
class HceBroadcaster {
  HceBroadcaster._();

  static const MethodChannel _channel = MethodChannel('com.lazervault.app/hce');

  /// True only on an Android device that has the HCE feature AND NFC enabled.
  /// iOS, NFC-off, and non-HCE hardware all return false → caller falls back to
  /// Session ID mode.
  static Future<bool> isSupported() async {
    if (!Platform.isAndroid) return false;
    try {
      return await _channel.invokeMethod<bool>('isHceSupported') ?? false;
    } catch (_) {
      return false;
    }
  }

  /// Begin presenting [payload] (the session's NFC text payload) as a readable
  /// NDEF tag. Returns true if emulation started; false if HCE is unavailable
  /// (caller should switch to Session ID mode and tell the user).
  static Future<bool> startBroadcast(String payload) async {
    if (!Platform.isAndroid || payload.isEmpty) return false;
    try {
      return await _channel.invokeMethod<bool>(
            'startBroadcast',
            {'payload': payload},
          ) ??
          false;
    } catch (_) {
      return false;
    }
  }

  /// Stop being readable (receiver screen closed / session completed/expired).
  /// Safe to call unconditionally.
  static Future<void> stop() async {
    if (!Platform.isAndroid) return;
    try {
      await _channel.invokeMethod('stop');
    } catch (_) {/* best-effort */}
  }
}
