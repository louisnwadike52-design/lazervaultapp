/// Parses a timestamp field from the planning backend.
///
/// The lifestyle-gateway marshals protobuf structs with Go's `encoding/json`,
/// which has no special handling for `google.protobuf.Timestamp` — so every
/// timestamp arrives as a `{"seconds": <int>, "nanos": <int>}` object, NOT an
/// RFC3339 string. Calling `DateTime.parse(v as String)` on that throws, which
/// is why Task/Event/TimeBlock/Category lists silently came back empty.
///
/// This tolerates all three shapes the backend could realistically send:
///   • `{"seconds": N, "nanos": M}`  (current gateway output)
///   • an RFC3339 string             (if the gateway ever switches to protojson)
///   • null / empty                  (unset optional timestamp)
///
/// Mirrors the inline `ts()` helper in Reminder.fromBackendJson.
DateTime? parsePlanTimestamp(dynamic v) {
  if (v == null) return null;
  if (v is String) {
    if (v.isEmpty) return null;
    return DateTime.tryParse(v);
  }
  if (v is Map) {
    final secs = v['seconds'];
    final nanos = v['nanos'];
    if (secs == null && nanos == null) return null;
    final millis = ((secs as num?)?.toInt() ?? 0) * 1000 +
        (((nanos as num?)?.toInt() ?? 0) ~/ 1000000);
    return DateTime.fromMillisecondsSinceEpoch(millis, isUtc: true).toLocal();
  }
  return null;
}

/// Same as [parsePlanTimestamp] but never null — for required fields
/// (created_at/updated_at/start_time/end_time). Falls back to now() so a
/// malformed/absent value can never crash list parsing.
DateTime parsePlanTimestampRequired(dynamic v) =>
    parsePlanTimestamp(v) ?? DateTime.now();
