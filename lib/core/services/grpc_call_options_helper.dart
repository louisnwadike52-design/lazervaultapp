import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grpc/grpc.dart';

class GrpcCallOptionsHelper {
  static const String _accessTokenKey = 'access_token';
  final FlutterSecureStorage storage;

  GrpcCallOptionsHelper(this.storage);

  Future<CallOptions> withAuth([CallOptions? options]) async {
    final accessToken = await storage.read(key: _accessTokenKey);

    if (accessToken == null || accessToken.isEmpty) {
      return options ?? CallOptions();
    }

    final metadata = <String, String>{
      'authorization': 'Bearer $accessToken',
    };

    if (options != null && options.metadata.isNotEmpty) {
      metadata.addAll(options.metadata);
    }

    return CallOptions(metadata: metadata);
  }
}
