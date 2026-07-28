import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/services/locale_manager.dart';

import 'package:lazervault/src/features/plan_my_day/notes/domain/note.dart';

/// HTTP client for Plan My Day notes (lifestyle-gateway /api/v1/planning/notes).
/// Mirrors ContactRepository (base-URL normalization + bearer + X-Locale/Account).
class NoteRepository {
  final String _baseUrl;
  final AccountManager _accountManager;
  final LocaleManager _localeManager;
  final http.Client _client;
  final FlutterSecureStorage _storage;

  static const Duration _timeout = Duration(seconds: 30);
  static const String _accessTokenKey = 'access_token';

  static String _normalizeBase(String base) => base
      .replaceAll(RegExp(r'/+$'), '')
      .replaceAll(RegExp(r'/api/v1$'), '');

  NoteRepository({
    String? baseUrl,
    required AccountManager accountManager,
    required LocaleManager localeManager,
    http.Client? client,
    FlutterSecureStorage? storage,
  })  : _baseUrl = _normalizeBase(baseUrl ?? endpointRegistry.httpLifestyle),
        _accountManager = accountManager,
        _localeManager = localeManager,
        _client = client ?? http.Client(),
        _storage = storage ?? const FlutterSecureStorage();

  Future<Map<String, String>> _headers() async {
    final token = await _storage.read(key: _accessTokenKey);
    if (token == null || token.isEmpty) {
      throw Exception('No authentication token found');
    }
    final h = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'X-Locale': _localeManager.currentLocale,
    };
    final acc = _accountManager.activeAccountId;
    if (acc != null && acc.isNotEmpty) h['X-Account-Id'] = acc;
    return h;
  }

  Uri _uri(String path) => Uri.parse('$_baseUrl/api/v1/planning$path');

  Future<List<Note>> getNotes() async {
    final res =
        await _client.get(_uri('/notes'), headers: await _headers()).timeout(_timeout);
    final data = _ok(res, 'Failed to load notes');
    final list = (data['notes'] as List<dynamic>?) ?? const [];
    return list.map((e) => Note.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<Note> createNote(Note note) async {
    final res = await _client
        .post(_uri('/notes'),
            headers: await _headers(), body: jsonEncode(note.toJson()))
        .timeout(_timeout);
    final data = _ok(res, 'Failed to create note');
    return Note.fromJson(data['note'] as Map<String, dynamic>);
  }

  Future<Note> updateNote(String id, Note note) async {
    final res = await _client
        .put(_uri('/notes/$id'),
            headers: await _headers(), body: jsonEncode(note.toJson()))
        .timeout(_timeout);
    final data = _ok(res, 'Failed to update note');
    return Note.fromJson(data['note'] as Map<String, dynamic>);
  }

  Future<void> deleteNote(String id) async {
    final res = await _client
        .delete(_uri('/notes/$id'), headers: await _headers())
        .timeout(_timeout);
    _ok(res, 'Failed to delete note');
  }

  Map<String, dynamic> _ok(http.Response res, String err) {
    if (res.statusCode >= 200 && res.statusCode < 300) {
      return res.body.isEmpty
          ? const {}
          : jsonDecode(res.body) as Map<String, dynamic>;
    }
    throw Exception('$err (${res.statusCode})');
  }
}
