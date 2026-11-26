/// ONE NORMALISED LOOKUP, SO A SPELLING CANNOT DECIDE THE OUTCOME.
///
/// THE TRAP. grpc-gateway marshals protobuf field names to **camelCase** by
/// default, while the protos — and most hand-written Go handlers — spell them
/// snake_case. A client that reads only one spelling decodes EMPTY and the
/// call still looks successful, so the failure is silent and lands far from
/// its cause.
///
/// Measured 2026-11-12: the BVN lookup service read only `error_code` /
/// `error_message`, so every failure arrived with an empty code and an empty
/// message. A customer whose DATE OF BIRTH disagreed with her BVN record was
/// told her one-time code was wrong — repeatedly, against a three-attempt cap
/// — while the server was returning "That date doesn't match the one
/// registered against this BVN… 2 tries left" and nothing displayed it.
///
/// LOWERCASING ALONE IS NOT ENOUGH: `error_code` and `errorcode` still differ
/// by the underscore. Keys are lowercased AND stripped of `_` and `-`, so
/// `error_code`, `errorCode`, `Error-Code` and `ERRORCODE` collapse to one.

/// normaliseJsonKeys collapses every key to a single canonical spelling.
Map<String, dynamic> normaliseJsonKeys(Map<String, dynamic> decoded) {
  final out = <String, dynamic>{};
  decoded.forEach((k, v) {
    out[canonicalJsonKey(k)] = v;
  });
  return out;
}

/// canonicalJsonKey is the normal form: lowercase, no separators.
String canonicalJsonKey(String k) =>
    k.toLowerCase().replaceAll('_', '').replaceAll('-', '');

/// jsonString reads a field by ANY spelling, trimmed, or '' when absent.
///
/// Pass the canonical name (`errorcode`), not a wire spelling — the point is
/// that the caller never has to know which convention the server used.
String jsonString(Map<String, dynamic> decoded, String canonical) {
  final v = normaliseJsonKeys(decoded)[canonical];
  return v is String ? v.trim() : '';
}
