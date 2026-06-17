import 'dart:convert';

/// Decodes a JWT payload (middle segment) without signature verification.
/// Use only to read non-sensitive claims already bound to the token in use.
Map<String, dynamic>? decodeJwtPayload(String token) {
  final parts = token.split('.');
  if (parts.length != 3) return null;
  try {
    var segment = parts[1];
    final pad = segment.length % 4;
    if (pad == 1) {
      segment += '===';
    } else if (pad == 2) {
      segment += '==';
    } else if (pad == 3) {
      segment += '=';
    }
    segment = segment.replaceAll('-', '+').replaceAll('_', '/');
    final jsonStr = utf8.decode(base64.decode(segment));
    final decoded = jsonDecode(jsonStr);
    if (decoded is Map<String, dynamic>) return decoded;
    return null;
  } catch (_) {
    return null;
  }
}

List<String>? rolesFromJwtClaims(Map<String, dynamic>? claims) {
  if (claims == null) return null;
  final raw = claims['roles'];
  if (raw is List) {
    final out = raw.map((e) => e.toString()).where((s) => s.isNotEmpty).toList();
    return out.isEmpty ? null : out;
  }
  if (raw is String && raw.isNotEmpty) return [raw];
  final single = claims['role'];
  if (single is String && single.isNotEmpty) return [single];
  return null;
}

String? primaryRoleFromJwtClaims(Map<String, dynamic>? claims) {
  if (claims == null) return null;
  final single = claims['role'];
  if (single is String && single.isNotEmpty) return single;
  final list = rolesFromJwtClaims(claims);
  if (list != null && list.isNotEmpty) return list.first;
  return null;
}
