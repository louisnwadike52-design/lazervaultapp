import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/services/locale_manager.dart';

import 'package:lazervault/src/features/plan_my_day/habits/domain/habit.dart';

/// HTTP client for Plan My Day habits (lifestyle-gateway /api/v1/planning/habits).
class HabitRepository {
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

  HabitRepository({
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

  Future<List<Habit>> getHabits() async {
    final res = await _client
        .get(_uri('/habits'), headers: await _headers())
        .timeout(_timeout);
    final data = _ok(res, 'Failed to load habits');
    final list = (data['habits'] as List<dynamic>?) ?? const [];
    return list.map((e) => Habit.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<Habit> createHabit(Habit habit) async {
    final res = await _client
        .post(_uri('/habits'),
            headers: await _headers(), body: jsonEncode(habit.toJson()))
        .timeout(_timeout);
    final data = _ok(res, 'Failed to create habit');
    return Habit.fromJson(data['habit'] as Map<String, dynamic>);
  }

  Future<Habit> updateHabit(String id, Habit habit) async {
    final res = await _client
        .put(_uri('/habits/$id'),
            headers: await _headers(), body: jsonEncode(habit.toJson()))
        .timeout(_timeout);
    final data = _ok(res, 'Failed to update habit');
    return Habit.fromJson(data['habit'] as Map<String, dynamic>);
  }

  Future<void> deleteHabit(String id) async {
    final res = await _client
        .delete(_uri('/habits/$id'), headers: await _headers())
        .timeout(_timeout);
    _ok(res, 'Failed to delete habit');
  }

  /// Log a completion for [date] (defaults to today). Returns the new streak.
  Future<int> logCompletion(String id, {DateTime? date}) async {
    final body = <String, dynamic>{
      'date': (date ?? DateTime.now()).toIso8601String().substring(0, 10),
      'completed': true,
    };
    final res = await _client
        .post(_uri('/habits/$id/log'),
            headers: await _headers(), body: jsonEncode(body))
        .timeout(_timeout);
    final data = _ok(res, 'Failed to log habit');
    return data['current_streak'] as int? ?? 0;
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
