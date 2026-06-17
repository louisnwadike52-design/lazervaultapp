// AI Scan session persistence — journal the in-flight scan session to
// SharedPreferences so a user who navigates away mid-scan can resume.
//
// Stored shape (JSON):
//   {
//     "session_id":  "...",
//     "scan_type":   <int index into ScanType.values>,
//     "created_ms":  <int epoch ms>,
//     "status":      <int index into ScanStatus.values>,
//     "bank_details": null | { ... extracted BankDetails fields ... }
//   }
//
// A session older than [resumeTtl] is treated as stale and ignored on
// restore — we don't want week-old half-finished scans popping back.

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/scan_entities.dart';

class AiScanSessionStore {
  static const _key = 'ai_scan:resumable_session';

  /// Sessions older than this are discarded on restore.
  static const resumeTtl = Duration(hours: 1);

  Future<void> save({
    required ScanSession session,
    BankDetails? bankDetails,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final json = <String, dynamic>{
      'session_id': session.id,
      'scan_type': session.scanType.index,
      'created_ms': session.createdAt.millisecondsSinceEpoch,
      'status': session.status.index,
      if (bankDetails != null) 'bank_details': _bankDetailsToJson(bankDetails),
    };
    await prefs.setString(_key, jsonEncode(json));
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }

  /// Try to restore a non-stale session. Returns null when no resumable
  /// session exists OR when it has aged out beyond [resumeTtl].
  Future<RestoredScan?> restore() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null || raw.isEmpty) return null;
    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      final createdMs = json['created_ms'] as int? ?? 0;
      final age = DateTime.now().millisecondsSinceEpoch - createdMs;
      if (age < 0 || age > resumeTtl.inMilliseconds) {
        // Stale — drop it on the floor.
        await clear();
        return null;
      }
      final scanTypeIdx = json['scan_type'] as int? ?? 0;
      final statusIdx = json['status'] as int? ?? 0;
      final session = ScanSession(
        id: json['session_id'] as String? ?? '',
        scanType: ScanType.values[
            scanTypeIdx.clamp(0, ScanType.values.length - 1)],
        createdAt: DateTime.fromMillisecondsSinceEpoch(createdMs),
        status: ScanStatus.values[
            statusIdx.clamp(0, ScanStatus.values.length - 1)],
      );
      BankDetails? bankDetails;
      final bd = json['bank_details'];
      if (bd is Map<String, dynamic>) {
        bankDetails = _bankDetailsFromJson(bd);
      }
      return RestoredScan(session: session, bankDetails: bankDetails);
    } catch (_) {
      // Corrupt journal — clear so we never trip on the same bad blob.
      await clear();
      return null;
    }
  }

  // ─── helpers ──────────────────────────────────────────────────────────────

  Map<String, dynamic> _bankDetailsToJson(BankDetails b) => {
        'account_number': b.accountNumber,
        'account_name': b.accountName,
        'bank_name': b.bankName,
        'bank_code': b.bankCode,
        'routing_number': b.routingNumber,
        'swift_code': b.swiftCode,
        'confidence_score': b.confidenceScore,
        'field_confidence': b.fieldConfidence,
        'account_type': b.accountType,
        'transfer_method': b.transferMethod,
      };

  BankDetails _bankDetailsFromJson(Map<String, dynamic> j) {
    final rawFc = j['field_confidence'];
    final Map<String, double> fc = {};
    if (rawFc is Map) {
      for (final e in rawFc.entries) {
        final v = e.value;
        if (v is num) fc[e.key.toString()] = v.toDouble();
      }
    }
    return BankDetails(
      accountNumber: j['account_number'] as String? ?? '',
      accountName: j['account_name'] as String? ?? '',
      bankName: j['bank_name'] as String? ?? '',
      bankCode: j['bank_code'] as String?,
      routingNumber: j['routing_number'] as String?,
      swiftCode: j['swift_code'] as String?,
      confidenceScore: (j['confidence_score'] as num?)?.toDouble() ?? 0.0,
      fieldConfidence: fc,
      accountType: j['account_type'] as String? ?? 'external',
      transferMethod: j['transfer_method'] as String? ?? 'paystack_transfer',
    );
  }
}

/// What [AiScanSessionStore.restore] hands back.
class RestoredScan {
  final ScanSession session;
  final BankDetails? bankDetails;
  const RestoredScan({required this.session, this.bankDetails});
}
