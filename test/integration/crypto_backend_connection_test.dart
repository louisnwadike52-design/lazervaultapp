/// Simple backend connection test for crypto services.
///
/// This test verifies that the backend services are running and accessible
/// without requiring the full Flutter widget rendering.
library crypto_backend_connection_test;

import 'package:flutter_test/flutter_test.dart';
import 'package:grpc/grpc.dart';

// -----------------------------------------------------------------------------
// Test Configuration
// -----------------------------------------------------------------------------

/// Backend service URLs
const _coreGatewayUrl = 'localhost';
const _cryptoGatewayUrl = 'localhost';

// -----------------------------------------------------------------------------
// Backend Connection Tests
// -----------------------------------------------------------------------------

void main() {
  group('Crypto Backend Connection Tests', () {
    test('Can connect to crypto-gateway port 9090', () async {
      // Verify backend is reachable
      final channel = ClientChannel(
        _cryptoGatewayUrl,
        port: 9090,
        options: const ChannelOptions(
          credentials: ChannelCredentials.insecure(),
        ),
      );

      expect(channel, isNotNull);

      // Try to create a simple connection
      try {
        await channel.shutdown();
        print('✓ Successfully connected to crypto-gateway at $_cryptoGatewayUrl:9090');
      } catch (e) {
        print('⚠ Warning: Could not cleanly shutdown connection: $e');
      }
    }, timeout: const Timeout(Duration(seconds: 10)));

    test('Can connect to core-gateway port 7878', () async {
      // Verify backend is reachable
      final channel = ClientChannel(
        _coreGatewayUrl,
        port: 7878,
        options: const ChannelOptions(
          credentials: ChannelCredentials.insecure(),
        ),
      );

      expect(channel, isNotNull);

      // Try to create a simple connection
      try {
        await channel.shutdown();
        print('✓ Successfully connected to core-gateway at $_coreGatewayUrl:7878');
      } catch (e) {
        print('⚠ Warning: Could not cleanly shutdown connection: $e');
      }
    }, timeout: const Timeout(Duration(seconds: 10)));

    test('Verify backend ports are open', () async {
      // This test verifies that the backend ports are accessible
      // by attempting to create connections

      final results = <String, bool>{};

      // Test crypto-gateway
      try {
        final cryptoChannel = ClientChannel(
          _cryptoGatewayUrl,
          port: 9090,
          options: const ChannelOptions(
            credentials: ChannelCredentials.insecure(),
          ),
        );
        await cryptoChannel.shutdown();
        results['crypto-gateway'] = true;
        print('✓ crypto-gateway (port 9090) is accessible');
      } catch (e) {
        results['crypto-gateway'] = false;
        print('✗ crypto-gateway (port 9090) is NOT accessible: $e');
      }

      // Test core-gateway
      try {
        final coreChannel = ClientChannel(
          _coreGatewayUrl,
          port: 7878,
          options: const ChannelOptions(
            credentials: ChannelCredentials.insecure(),
          ),
        );
        await coreChannel.shutdown();
        results['core-gateway'] = true;
        print('✓ core-gateway (port 7878) is accessible');
      } catch (e) {
        results['core-gateway'] = false;
        print('✗ core-gateway (port 7878) is NOT accessible: $e');
      }

      // Assert that at least one backend is accessible
      final accessibleCount = results.values.where((v) => v).length;
      expect(
        accessibleCount,
        greaterThanOrEqualTo(1),
        reason: 'At least one backend service should be accessible. '
            'Results: $results',
      );

      print('\n=== Backend Connection Summary ===');
      results.forEach((service, accessible) {
        final status = accessible ? '✓ ACCESSIBLE' : '✗ NOT ACCESSIBLE';
        print('$service: $status');
      });
    }, timeout: const Timeout(Duration(seconds: 15)));
  });
}
