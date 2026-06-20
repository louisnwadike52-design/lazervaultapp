import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';

/// Service for syncing with external calendars (Google, Outlook, etc.)
/// Uses the planning-gateway backend for actual API calls to external providers
class CalendarSyncService {
  final String _baseUrl;
  final AccountManager _accountManager;
  final GrpcCallOptionsHelper _callOptionsHelper;
  final FlutterSecureStorage _storage;

  static const String _accessTokenKey = 'access_token';

  /// The request paths below already carry the `/api/v1` prefix
  /// (`/api/v1/planning/calendar/...`). Both `PLANNING_GATEWAY_URL` and
  /// `endpointRegistry.httpPlanning` ALSO end in `/api/v1`, so without this the
  /// URL doubled to `.../api/v1/api/v1/planning/...` and 404'd. Strip a trailing
  /// `/api/v1` (and any trailing slash) so the final URL has exactly one.
  static String _normalizeBase(String base) {
    final trimmed = base.replaceAll(RegExp(r'/+$'), '');
    return trimmed.replaceAll(RegExp(r'/api/v1$'), '');
  }

  CalendarSyncService({
    String? baseUrl,
    required AccountManager accountManager,
    required GrpcCallOptionsHelper callOptionsHelper,
    FlutterSecureStorage? storage,
  })  : _baseUrl = _normalizeBase(baseUrl ?? endpointRegistry.httpPlanning),
        _accountManager = accountManager,
        _callOptionsHelper = callOptionsHelper,
        _storage = storage ?? const FlutterSecureStorage();

  Future<Map<String, String>> _getHeaders() async {
    final token = await _storage.read(key: _accessTokenKey);
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  /// Get the current sync status for all connected calendars
  Future<CalendarSyncStatus> getSyncStatus() async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$_baseUrl/api/v1/planning/calendar/sync-status'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return CalendarSyncStatus.fromJson(data);
    }

    return CalendarSyncStatus.empty();
  }

  /// Connect to Google Calendar
  ///
  /// [authCode] - OAuth authorization code from Google Sign-In
  Future<GoogleCalendarConnectionResult> connectGoogleCalendar({
    String? authCode,
    String? refreshToken,
  }) async {
    final headers = await _getHeaders();
    final response = await http.post(
      Uri.parse('$_baseUrl/api/v1/planning/calendar/google/connect'),
      headers: headers,
      body: jsonEncode({
        if (authCode != null) 'auth_code': authCode,
        if (refreshToken != null) 'refresh_token': refreshToken,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return GoogleCalendarConnectionResult(
        success: data['success'] ?? false,
        syncToken: data['sync_token'],
        eventsSynced: data['events_synced'] ?? 0,
      );
    }

    return GoogleCalendarConnectionResult(success: false);
  }

  /// Disconnect from Google Calendar
  Future<bool> disconnectGoogleCalendar() async {
    final headers = await _getHeaders();
    final response = await http.post(
      Uri.parse('$_baseUrl/api/v1/planning/calendar/google/disconnect'),
      headers: headers,
    );

    return response.statusCode == 200;
  }

  /// Sync events from Google Calendar
  ///
  /// [fullSync] - If true, performs a full sync. If false, incremental sync since last sync
  Future<CalendarSyncResult> syncGoogleCalendar({
    bool fullSync = false,
    String? syncToken,
  }) async {
    final headers = await _getHeaders();
    final response = await http.post(
      Uri.parse('$_baseUrl/api/v1/planning/calendar/google/sync'),
      headers: headers,
      body: jsonEncode({
        'full_sync': fullSync,
        if (syncToken != null) 'sync_token': syncToken,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return CalendarSyncResult(
        eventsAdded: data['events_added'] ?? 0,
        eventsUpdated: data['events_updated'] ?? 0,
        nextSyncToken: data['next_sync_token'],
      );
    }

    return CalendarSyncResult.empty();
  }

  /// Connect to Outlook Calendar
  Future<bool> connectOutlookCalendar({
    String? accessToken,
    String? refreshToken,
  }) async {
    final headers = await _getHeaders();
    final response = await http.post(
      Uri.parse('$_baseUrl/api/v1/planning/calendar/outlook/connect'),
      headers: headers,
      body: jsonEncode({
        if (accessToken != null) 'access_token': accessToken,
        if (refreshToken != null) 'refresh_token': refreshToken,
      }),
    );

    return response.statusCode == 200 || response.statusCode == 201;
  }

  /// Disconnect from Outlook Calendar
  Future<bool> disconnectOutlookCalendar() async {
    final headers = await _getHeaders();
    final response = await http.post(
      Uri.parse('$_baseUrl/api/v1/planning/calendar/outlook/disconnect'),
      headers: headers,
    );

    return response.statusCode == 200;
  }
}

/// Models for calendar sync data

class CalendarSyncStatus {
  final bool googleConnected;
  final String? googleLastSync;
  final bool outlookConnected;
  final String? outlookLastSync;

  CalendarSyncStatus({
    required this.googleConnected,
    this.googleLastSync,
    required this.outlookConnected,
    this.outlookLastSync,
  });

  factory CalendarSyncStatus.fromJson(Map<String, dynamic> json) {
    return CalendarSyncStatus(
      googleConnected: json['google_connected'] ?? false,
      googleLastSync: json['google_last_sync'],
      outlookConnected: json['outlook_connected'] ?? false,
      outlookLastSync: json['outlook_last_sync'],
    );
  }

  factory CalendarSyncStatus.empty() {
    return CalendarSyncStatus(
      googleConnected: false,
      outlookConnected: false,
    );
  }

  bool get hasAnyConnection => googleConnected || outlookConnected;
}

class GoogleCalendarConnectionResult {
  final bool success;
  final String? syncToken;
  final int eventsSynced;

  GoogleCalendarConnectionResult({
    required this.success,
    this.syncToken,
    this.eventsSynced = 0,
  });
}

class CalendarSyncResult {
  final int eventsAdded;
  final int eventsUpdated;
  final String? nextSyncToken;

  CalendarSyncResult({
    required this.eventsAdded,
    required this.eventsUpdated,
    this.nextSyncToken,
  });

  factory CalendarSyncResult.empty() {
    return CalendarSyncResult(
      eventsAdded: 0,
      eventsUpdated: 0,
    );
  }

  int get totalChanges => eventsAdded + eventsUpdated;
}
