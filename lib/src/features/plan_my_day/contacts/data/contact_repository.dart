import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/services/locale_manager.dart';

import 'package:lazervault/src/features/plan_my_day/contacts/domain/entities/contact.dart';
import 'package:lazervault/src/features/plan_my_day/contacts/domain/entities/contact_interaction.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/task.dart';

/// HTTP client for Plan My Day CRM contacts (lifestyle-gateway
/// /api/v1/planning/contacts). Mirrors PlanMyDayRepository: same base-URL
/// normalization, bearer token from shared secure storage, and X-Locale /
/// X-Account-Id scoping headers so contacts are region/account scoped.
class ContactRepository {
  final String _baseUrl;
  final AccountManager _accountManager;
  final LocaleManager _localeManager;
  final http.Client _client;
  final FlutterSecureStorage _storage;

  static const Duration _timeout = Duration(seconds: 30);
  static const String _accessTokenKey = 'access_token';

  static String _normalizeBase(String base) {
    final trimmed = base.replaceAll(RegExp(r'/+$'), '');
    return trimmed.replaceAll(RegExp(r'/api/v1$'), '');
  }

  ContactRepository({
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
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'X-Locale': _localeManager.currentLocale,
    };
    final accountId = _accountManager.activeAccountId;
    if (accountId != null && accountId.isNotEmpty) {
      headers['X-Account-Id'] = accountId;
    }
    return headers;
  }

  Uri _uri(String path) => Uri.parse('$_baseUrl/api/v1/planning$path');

  Future<List<Contact>> getContacts() async {
    final res = await _client
        .get(_uri('/contacts'), headers: await _headers())
        .timeout(_timeout);
    final data = _ok(res, 'Failed to load contacts');
    final list = (data['contacts'] as List<dynamic>?) ?? const [];
    return list
        .map((e) => Contact.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Contact> getContact(String id) async {
    final res = await _client
        .get(_uri('/contacts/$id'), headers: await _headers())
        .timeout(_timeout);
    final data = _ok(res, 'Failed to load contact');
    return Contact.fromJson(data['contact'] as Map<String, dynamic>);
  }

  Future<Contact> createContact(Contact contact) async {
    final res = await _client
        .post(_uri('/contacts'),
            headers: await _headers(), body: jsonEncode(contact.toJson()))
        .timeout(_timeout);
    final data = _ok(res, 'Failed to create contact');
    return Contact.fromJson(data['contact'] as Map<String, dynamic>);
  }

  Future<Contact> updateContact(String id, Contact contact) async {
    final res = await _client
        .put(_uri('/contacts/$id'),
            headers: await _headers(), body: jsonEncode(contact.toJson()))
        .timeout(_timeout);
    final data = _ok(res, 'Failed to update contact');
    return Contact.fromJson(data['contact'] as Map<String, dynamic>);
  }

  Future<void> deleteContact(String id) async {
    final res = await _client
        .delete(_uri('/contacts/$id'), headers: await _headers())
        .timeout(_timeout);
    _ok(res, 'Failed to delete contact');
  }

  /// Tasks linked to a contact (People → tasks). Backed by the gateway route
  /// GET /contacts/:id/tasks (filters the user's tasks by contact_id).
  Future<List<Task>> getTasksForContact(String contactId) async {
    final res = await _client
        .get(_uri('/contacts/$contactId/tasks'), headers: await _headers())
        .timeout(_timeout);
    final data = _ok(res, 'Failed to load linked tasks');
    final list = (data['tasks'] as List<dynamic>?) ?? const [];
    return list
        .map((e) => Task.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<ContactInteraction>> getInteractions(String contactId) async {
    final res = await _client
        .get(_uri('/contacts/$contactId/interactions'),
            headers: await _headers())
        .timeout(_timeout);
    final data = _ok(res, 'Failed to load interactions');
    final list = (data['interactions'] as List<dynamic>?) ?? const [];
    return list
        .map((e) => ContactInteraction.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<ContactInteraction> logInteraction(
      String contactId, ContactInteraction interaction) async {
    final res = await _client
        .post(_uri('/contacts/$contactId/interactions'),
            headers: await _headers(), body: jsonEncode(interaction.toJson()))
        .timeout(_timeout);
    final data = _ok(res, 'Failed to log interaction');
    return ContactInteraction.fromJson(
        data['interaction'] as Map<String, dynamic>);
  }

  Map<String, dynamic> _ok(http.Response res, String err) {
    if (res.statusCode >= 200 && res.statusCode < 300) {
      if (res.body.isEmpty) return const {};
      final data = jsonDecode(res.body) as Map<String, dynamic>;
      return data;
    }
    throw Exception('$err (${res.statusCode})');
  }
}
