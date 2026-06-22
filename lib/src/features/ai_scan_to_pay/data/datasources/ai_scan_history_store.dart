// Local, on-device history of AI Scan-to-Pay attempts.
//
// The backend /scan/history only records OCR extractions, not whether a payment
// completed. This store is the source of truth for the "Previous scans" list: it
// records every resolved scan as `incomplete`, then upgrades it to `completed`
// with the full [PaymentReceipt] when the payment lands — so the history screen
// can show the receipt for completed ones and a "didn't complete" notice for the
// rest. Persisted in SharedPreferences (newest-first, capped).
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/scan_entities.dart';

class AiScanHistoryEntry {
  final String id;
  final DateTime createdAt;
  final String title;
  final String subtitle;
  final String typeName; // ScanIntentType.name
  final double amount;
  final String currency;
  final String status; // 'completed' | 'incomplete'
  final PaymentReceipt? receipt;

  const AiScanHistoryEntry({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.subtitle,
    required this.typeName,
    required this.amount,
    required this.currency,
    required this.status,
    this.receipt,
  });

  bool get isCompleted => status == 'completed' && receipt != null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'createdAt': createdAt.toIso8601String(),
        'title': title,
        'subtitle': subtitle,
        'typeName': typeName,
        'amount': amount,
        'currency': currency,
        'status': status,
        if (receipt != null) 'receipt': _receiptToJson(receipt!),
      };

  factory AiScanHistoryEntry.fromJson(Map<String, dynamic> j) =>
      AiScanHistoryEntry(
        id: (j['id'] ?? '').toString(),
        createdAt: DateTime.tryParse(j['createdAt']?.toString() ?? '') ??
            DateTime.now(),
        title: (j['title'] ?? 'Scan').toString(),
        subtitle: (j['subtitle'] ?? '').toString(),
        typeName: (j['typeName'] ?? 'unknown').toString(),
        amount: (j['amount'] is num)
            ? (j['amount'] as num).toDouble()
            : double.tryParse('${j['amount']}') ?? 0,
        currency: (j['currency'] ?? 'NGN').toString(),
        status: (j['status'] ?? 'incomplete').toString(),
        receipt: j['receipt'] is Map
            ? _receiptFromJson(Map<String, dynamic>.from(j['receipt'] as Map))
            : null,
      );

  static Map<String, dynamic> _receiptToJson(PaymentReceipt r) => {
        'id': r.id,
        'reference': r.reference,
        'recipientName': r.recipientName,
        'accountNumber': r.accountNumber,
        'bankName': r.bankName,
        'amount': r.amount,
        'currency': r.currency,
        'status': r.status,
        'description': r.description,
        'transactionDate': r.transactionDate.toIso8601String(),
        'transferReference': r.transferReference,
        'isExternal': r.isExternal,
      };

  static PaymentReceipt _receiptFromJson(Map<String, dynamic> j) =>
      PaymentReceipt(
        id: (j['id'] ?? '').toString(),
        reference: (j['reference'] ?? '').toString(),
        recipientName: (j['recipientName'] ?? '').toString(),
        accountNumber: (j['accountNumber'] ?? '').toString(),
        bankName: (j['bankName'] ?? '').toString(),
        amount: (j['amount'] is num)
            ? (j['amount'] as num).toDouble()
            : double.tryParse('${j['amount']}') ?? 0,
        currency: (j['currency'] ?? 'NGN').toString(),
        status: (j['status'] ?? 'completed').toString(),
        description: j['description']?.toString(),
        transactionDate:
            DateTime.tryParse(j['transactionDate']?.toString() ?? '') ??
                DateTime.now(),
        transferReference: j['transferReference']?.toString(),
        isExternal: j['isExternal'] == true,
      );
}

class AiScanHistoryStore {
  static const String _key = 'ai_scan_history_v1';
  static const int _cap = 40;

  Future<List<AiScanHistoryEntry>> list() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null || raw.isEmpty) return [];
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) return [];
      return decoded
          .whereType<Map>()
          .map((m) =>
              AiScanHistoryEntry.fromJson(Map<String, dynamic>.from(m)))
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> _save(List<AiScanHistoryEntry> entries) async {
    final prefs = await SharedPreferences.getInstance();
    final trimmed = entries.take(_cap).toList();
    await prefs.setString(
        _key, jsonEncode(trimmed.map((e) => e.toJson()).toList()));
  }

  /// Record a freshly-resolved scan as `incomplete`. Returns the entry id so the
  /// caller can later [markCompleted] it once the payment lands.
  Future<String> record({
    required String id,
    required ScanPaymentIntent intent,
  }) async {
    final entries = await list();
    final entry = AiScanHistoryEntry(
      id: id,
      createdAt: DateTime.now(),
      title: intent.title,
      subtitle: intent.subtitle,
      typeName: intent.type.name,
      amount: intent.amount ?? 0,
      currency: intent.currency,
      status: 'incomplete',
    );
    await _save([entry, ...entries]);
    return id;
  }

  /// Upgrade an entry to `completed` and attach the receipt.
  Future<void> markCompleted(String id, PaymentReceipt receipt) async {
    final entries = await list();
    final idx = entries.indexWhere((e) => e.id == id);
    if (idx == -1) {
      // No prior record (e.g. resolved before this store existed) — add one.
      await _save([
        AiScanHistoryEntry(
          id: id,
          createdAt: receipt.transactionDate,
          title: receipt.recipientName,
          subtitle: receipt.maskedAccountNumber,
          typeName: 'unknown',
          amount: receipt.amount,
          currency: receipt.currency,
          status: 'completed',
          receipt: receipt,
        ),
        ...entries,
      ]);
      return;
    }
    final old = entries[idx];
    entries[idx] = AiScanHistoryEntry(
      id: old.id,
      createdAt: old.createdAt,
      title: receipt.recipientName.isNotEmpty ? receipt.recipientName : old.title,
      subtitle: old.subtitle,
      typeName: old.typeName,
      amount: receipt.amount,
      currency: receipt.currency,
      status: 'completed',
      receipt: receipt,
    );
    await _save(entries);
  }
}
