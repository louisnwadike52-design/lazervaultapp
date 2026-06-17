import 'package:flutter_dotenv/flutter_dotenv.dart';

/// API base URL - configured via environment variable
/// Uses HTTP_API_HOST, CHAT_GATEWAY_URL, or defaults to production API
String get kBaseUrl =>
    dotenv.env['HTTP_API_HOST'] ??
    dotenv.env['CHAT_GATEWAY_URL'] ??
    'api.lazervault.com';

/// Create user endpoint
const kCreateUserEndpoint = '/api/v1/users';

/// Get user endpoint
const kGetUserEndpoint = '/api/v1/users';
