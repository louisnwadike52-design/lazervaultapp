import 'package:dio/dio.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';

/// Result of submitting an issue report. Keep it a tiny sealed-ish pair
/// so the dialog can render success vs error without unpacking a Dio
/// exception object at the UI layer.
class ReportIssueResult {
  final bool ok;
  final String? reportId;
  final String? errorMessage;

  const ReportIssueResult.success(this.reportId)
      : ok = true,
        errorMessage = null;
  const ReportIssueResult.failure(this.errorMessage)
      : ok = false,
        reportId = null;
}

/// Thin HTTP client for the exchange "Report Issue" surface. Posts to
/// financial-gateway's explicit /v1/exchange/report-issue route, which
/// reverse-proxies to exchange-service's raw HTTP port. No gRPC/proto
/// involved — this is a user-reported text blob, not a transactional
/// operation.
class ReportIssueService {
  final Dio _dio;
  final GrpcCallOptionsHelper _callOptionsHelper;

  /// Android emulator uses 10.0.2.2 to reach host machine — financial-gateway
  /// HTTP lives on 8016. Overridable in tests.
  final String baseUrl;

  ReportIssueService({
    required Dio dio,
    required GrpcCallOptionsHelper callOptionsHelper,
    this.baseUrl = 'http://10.0.2.2:8016',
  })  : _dio = dio,
        _callOptionsHelper = callOptionsHelper;

  Future<ReportIssueResult> submit({
    required String message,
    String? transactionId,
    String? transactionReference,
  }) async {
    try {
      final opts = await _callOptionsHelper.withAuth();
      final response = await _dio.post(
        '$baseUrl/v1/exchange/report-issue',
        data: {
          'message': message,
          if (transactionId != null && transactionId.isNotEmpty)
            'transaction_id': transactionId,
          if (transactionReference != null && transactionReference.isNotEmpty)
            'transaction_reference': transactionReference,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            ...opts.metadata,
          },
          // Treat all 2xx as success, surface 4xx/5xx to the caller.
          validateStatus: (_) => true,
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        String? id;
        if (data is Map && data['id'] is String) id = data['id'] as String;
        return ReportIssueResult.success(id);
      }
      // Backend returned a structured error body in most cases.
      final body = response.data;
      String? msg;
      if (body is Map && body['message'] is String) {
        msg = body['message'] as String;
      }
      return ReportIssueResult.failure(
        msg ?? 'Report failed (HTTP ${response.statusCode})',
      );
    } on DioException catch (e) {
      return ReportIssueResult.failure(
        e.message ?? 'Network error while submitting report',
      );
    } catch (e) {
      return ReportIssueResult.failure('Unexpected error: $e');
    }
  }
}
