import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/services/locale_manager.dart';

class GrpcCallOptionsHelper {
  static const String _accessTokenKey = 'access_token';
  final FlutterSecureStorage storage;
  final LocaleManager? localeManager;

  GrpcCallOptionsHelper(this.storage, {this.localeManager});

  /// Create CallOptions with authorization and locale metadata
  ///
  /// This is the primary method that should be used for all gRPC calls.
  /// It automatically injects:
  /// - Authorization: Bearer token
  /// - Accept-Language: locale (e.g., "en-US", "en-GB")
  /// - X-Country-Code: country code (e.g., "US", "GB")
  Future<CallOptions> withAuth([CallOptions? options]) async {
    final accessToken = await storage.read(key: _accessTokenKey);

    print('=== GrpcCallOptionsHelper.withAuth ===');
    print('Access token present: ${accessToken != null && accessToken.isNotEmpty}');
    if (accessToken != null && accessToken.isNotEmpty) {
      print('Access token length: ${accessToken.length}');
      print('Access token prefix: ${accessToken.substring(0, accessToken.length > 20 ? 20 : accessToken.length)}...');
    }

    final metadata = <String, String>{};

    // Add authorization header
    if (accessToken != null && accessToken.isNotEmpty) {
      metadata['authorization'] = 'Bearer $accessToken';
    } else {
      print('WARNING: No access token found in secure storage');
    }

    // Add locale metadata if LocaleManager is available
    if (localeManager != null) {
      final localeMetadata = localeManager!.getLocaleMetadata();
      metadata.addAll(localeMetadata);
      print('Locale metadata added: ${localeMetadata}');
    }

    // Preserve any existing metadata from options
    if (options != null && options.metadata.isNotEmpty) {
      metadata.addAll(options.metadata);
    }

    return CallOptions(metadata: metadata);
  }

  /// Backward compatibility: withAuthAndLocale is now the same as withAuth
  @Deprecated('Use withAuth() instead - it now includes locale automatically')
  Future<CallOptions> withAuthAndLocale([CallOptions? options]) async {
    return withAuth(options);
  }
}
