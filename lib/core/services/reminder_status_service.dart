import 'package:dio/dio.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';

/// Result of a reminder pause/resume call. A tiny typed pair so the UI can
/// render success vs. a friendly failure message without unpacking a Dio
/// exception at the widget layer.
///
/// On the money/utility-reminder path the backend returns a 409 with a
/// human-readable `message` when the reminder isn't in a state that can be
/// paused/resumed (already paused, already active, already fired) — surface
/// that text verbatim, never a raw stack trace.
class ReminderStatusResult {
  /// True when the server confirmed the transition (`success: true`, HTTP 200).
  final bool ok;

  /// New status reported by the server on success (`paused` / `resumed`).
  final String? status;

  /// Friendly message to show on failure (server `message` when present).
  final String? message;

  const ReminderStatusResult.success(this.status)
      : ok = true,
        message = null;

  const ReminderStatusResult.failure(this.message)
      : ok = false,
        status = null;
}

/// Thin authed HTTP client for pausing/resuming bill-payment reminders.
///
/// Posts to commerce-gateway's `/bills/reminders/{pause,resume}` routes. The
/// base URL is resolved from [EndpointRegistry.httpCommerce] (value already
/// ends in `/api/v1`) and the JWT bearer + user-context headers are attached
/// via [GrpcCallOptionsHelper.withAuth] — the exact pattern the exchange
/// "Report Issue" service uses, so tokens are never hardcoded and the base
/// URL follows the admin-tunable endpoint registry.
class ReminderStatusService {
  final Dio _dio;
  final GrpcCallOptionsHelper _callOptionsHelper;

  /// commerce-gateway HTTP base — ends with `/api/v1`. Overridable in tests.
  final String baseUrl;

  ReminderStatusService({
    required Dio dio,
    required GrpcCallOptionsHelper callOptionsHelper,
    String? baseUrl,
  })  : _dio = dio,
        _callOptionsHelper = callOptionsHelper,
        baseUrl = baseUrl ?? endpointRegistry.httpCommerce;

  /// Pause a scheduled reminder so it stops firing until resumed.
  Future<ReminderStatusResult> pauseReminder(
    String billType,
    String reminderId,
  ) =>
      _post('pause', billType, reminderId);

  /// Resume a previously paused reminder.
  Future<ReminderStatusResult> resumeReminder(
    String billType,
    String reminderId,
  ) =>
      _post('resume', billType, reminderId);

  Future<ReminderStatusResult> _post(
    String action,
    String billType,
    String reminderId,
  ) async {
    try {
      final opts = await _callOptionsHelper.withAuth();
      final response = await _dio.post(
        '$baseUrl/bills/reminders/$action',
        data: {
          'bill_type': billType,
          'reminder_id': reminderId,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            ...opts.metadata,
          },
          // Surface 2xx as success and 4xx/5xx to the caller so we can read
          // the structured `message` on a 409/401 instead of throwing.
          validateStatus: (_) => true,
        ),
      );

      final data = response.data;
      if (response.statusCode == 200 &&
          data is Map &&
          data['success'] == true) {
        final status = data['status'] is String ? data['status'] as String : null;
        return ReminderStatusResult.success(status);
      }

      String? msg;
      if (data is Map && data['message'] is String) {
        msg = data['message'] as String;
      }
      return ReminderStatusResult.failure(
        msg ?? 'Could not update this reminder (HTTP ${response.statusCode}).',
      );
    } on DioException catch (e) {
      return ReminderStatusResult.failure(
        e.message ?? 'Network error while updating the reminder.',
      );
    } catch (_) {
      return ReminderStatusResult.failure(
        'Something went wrong updating the reminder.',
      );
    }
  }
}
